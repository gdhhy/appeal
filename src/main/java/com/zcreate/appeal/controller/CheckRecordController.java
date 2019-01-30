package com.zcreate.appeal.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.zcreate.DeployRunning;
import com.zcreate.appeal.dao.AffairMapper;
import com.zcreate.appeal.dao.CheckRecordMapper;
import com.zcreate.appeal.pojo.Affair;
import com.zcreate.appeal.pojo.CheckRecord;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import com.zcreate.upload.pojo.FileBucket;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@Transactional
@RequestMapping("/appeal")
public class CheckRecordController {
    private static Logger logger = Logger.getLogger(CheckRecordController.class);

    private static String relative_directory = "upload";
    private static String UPLOAD_LOCATION = DeployRunning.getDir() + relative_directory + File.separator;

    @Autowired
    private AffairMapper affairMapper;
    @Autowired
    private CheckRecordMapper checkRecordMapper;

    private Gson gson = new GsonBuilder().serializeNulls().setDateFormat("yyyy-MM-dd HH:mm").create();
    private SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    //private static String UPLOAD_LOCATION = DeployRunning.getDir() + imageDir + File.separator;

    /*
     public void setImageDir(String imageDir) {
        this.imageDir = imageDir;
    }*/

    @ResponseBody
    @RequestMapping(value = "/showAffair", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
    public String showAffair(@RequestParam(value = "createUserID", required = false) Integer createUserID,
                             @RequestParam(value = "affairID", required = false) Integer affairID) {
        Map<String, Object> param = new HashMap<>();
        param.put("createUserID", createUserID);
        param.put("affairID", affairID);
        List<Affair> affair = affairMapper.getAffair(param);

        return gson.toJson(affair);
    }

    @ResponseBody
    @RequestMapping(value = "/listAffair", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
    public String listAffair(@RequestParam(value = "createUserID", required = false) String createUserID) {
        Map<String, Object> param = new HashMap<>();
        param.put("createUserID", createUserID);
        List<Affair> affair = affairMapper.selectAffair(param);

        return returnJson(affair);
    }

    private String returnJson(List affair) {
        Map<String, Object> result = new HashMap<>();
        result.put("data", affair);
        result.put("iTotalRecords", affair.size());
        result.put("iTotalDisplayRecords", affair.size());

        return gson.toJson(result);
    }

    @ResponseBody
    @RequestMapping(value = "/saveAffair", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    public String saveAffair(@ModelAttribute("affair") Affair affair) {//
        System.out.println("affair = " + affair);
        Map<String, Object> map = new HashMap<>();
        int result;
        map.put("title", "保存聚集事件");
        logger.debug("getTogetherTime=" + affair.getTogetherTime());
       /* try {
            affair.setTogetherTime(new Timestamp(formatter.parse(affair.getTogetherTimeString()).getTime()));
        } catch (ParseException e) {
            e.printStackTrace();
        }*/

        if (affair.getAffairID() != null)
            result = affairMapper.updateAffair(affair);
        else
            result = affairMapper.insertAffair(affair);
        map.put("succeed", result > 0);

        return gson.toJson(map);
    }


    @ResponseBody
    @RequestMapping(value = "/deleteAffair", method = RequestMethod.POST) //todo change post
    public String deleteAffair(@RequestParam("affairID") int affairID) {
        int result = affairMapper.deleteAffair(affairID);//如果返回-1, 相加就是0

        if (result >= 0)//==0 是可能没有设置二维码
            result += affairMapper.deleteAffair(affairID);
        Map<String, Object> map = new HashMap<>();
        map.put("succeed", result > 0);
        map.put("affectedRowCount", result);

        return gson.toJson(map);
    }


    @ResponseBody
    @RequestMapping(value = "/listCheckRecord", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
    public String listCheckRecord(@RequestParam(value = "affairID", required = false) Integer affairID) {
        Map<String, Object> param = new HashMap<>();
        param.put("affairID", affairID);
        List<CheckRecord> checkRecord = checkRecordMapper.selectCheckRecord(param);
        return returnJson(checkRecord);
    }

    @ResponseBody
    @RequestMapping(value = "/uploadCheckRecord", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    public String uploadCheckRecord(@Valid FileBucket fileBucket, BindingResult result) {
        Map<String, Object> resultMap = new HashMap<>();

        if (result.hasErrors()) {
            List<Map<String, Object>> files = new ArrayList<>();
            Map<String, Object> file = new HashMap<>();
            file.put("error", "validation errors");
            files.add(file);

            resultMap.put("success", false);
            resultMap.put("error", files);
        } else if (fileBucket.getFile() == null) {
            resultMap.put("success", false);
            resultMap.put("error", "未发现上传文件");
        } else {
            logger.debug("Fetching file");
            logger.debug("fileBucket=" + fileBucket);
            logger.debug("fileBucket.getFile() =" + fileBucket.getFile());

            logger.debug("fileBucket.getFile().getOriginalFilename()=" + fileBucket.getFile().getOriginalFilename());
            //MultipartFile multipartFile = fileBucket.getFile();
            Map<String, Object> file = new HashMap<>();
            String server_save_filename = fileBucket.getFile().getOriginalFilename().substring(0, fileBucket.getFile().getOriginalFilename().indexOf("."));
            server_save_filename += "_" + (new Date()).getTime() + fileBucket.getFile().getOriginalFilename().substring(fileBucket.getFile().getOriginalFilename().indexOf((".")));
            logger.debug("server_save_filename:" + server_save_filename);
            try {
                //File  file1=
                FileCopyUtils.copy(fileBucket.getFile().getBytes(), new File(UPLOAD_LOCATION + server_save_filename));
                //导入
                InputStream is = new FileInputStream(UPLOAD_LOCATION + server_save_filename);
                HSSFWorkbook workbook = new HSSFWorkbook(is);
                HSSFSheet sheet = workbook.getSheet("Sheet1");
                int succeed = 0;
                for (int startRow = 2; startRow < sheet.getLastRowNum(); startRow++) {
                    CheckRecord record = new CheckRecord();
                    record.setCheckMethod(sheet.getRow(startRow).getCell(0).toString());
                    record.setCheckType(sheet.getRow(startRow).getCell(1).toString());
                    record.setName(sheet.getRow(startRow).getCell(4).toString());
                    record.setIdNo(sheet.getRow(startRow).getCell(5).toString());
                    record.setSex(sheet.getRow(startRow).getCell(6).toString());
                    record.setAddress(sheet.getRow(startRow).getCell(7).toString());
                    //record.setCheckTime(sheet.getRow(startRow).getCell(8).toString());
                    record.setPolice(sheet.getRow(startRow).getCell(9).toString());
                    record.setPoliceman(sheet.getRow(startRow).getCell(10).toString());
                    record.setPoliceNo(sheet.getRow(startRow).getCell(11).toString());
                    record.setFilterCause(sheet.getRow(startRow).getCell(12).toString());
                    record.setSituation(sheet.getRow(startRow).getCell(13).toString());
                    record.setDataValid(sheet.getRow(startRow).getCell(14).toString());
                    checkRecordMapper.insertCheckRecord(record);
                    succeed++;
                }

                file.put("succeedNum", succeed);
            } catch (IOException e) {
                file.put("error", e.getMessage());
            }

            List<Map<String, Object>> files = new ArrayList<>();
            if (file.get("error") == null) {
                file.put("url", File.separator + relative_directory + File.separator + server_save_filename);
                resultMap.put("success", true);
                resultMap.put("status", "OK");
            }
            resultMap.putIfAbsent("success", false);
            files.add(file);

            resultMap.put("files", files);
        }

        return gson.toJson(resultMap);
    }
}
