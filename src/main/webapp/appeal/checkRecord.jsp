<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://cdn.bootcss.com/datatables/1.10.16/js/jquery.dataTables.min.js"></script>
<script src="http://ace.jeka.by/assets/js/jquery.dataTables.bootstrap.min.js"></script>
<script src="http://ace.jeka.by/assets/js/dataTables.buttons.min.js"></script>
<script src="http://ace.jeka.by/assets/js/dataTables.select.min.js"></script>
<script src="https://cdn.bootcss.com/jqueryui/1.12.1/jquery-ui.min.js"></script>
<script src="https://cdn.bootcss.com/jqueryui-touch-punch/0.2.3/jquery.ui.touch-punch.min.js"></script>
<script src="http://cdnjs.cloudflare.com/ajax/libs/x-editable/1.5.1/bootstrap3-editable/js/bootstrap-editable.js"></script>
<script src="http://ace.jeka.by/assets/js/ace-editable.min.js"></script>
<script src="/components/jquery.gritter/js/jquery.gritter.js"></script>

<script src="https://cdn.bootcss.com/moment.js/2.22.1/moment.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap-datetimepicker/4.17.47/js/bootstrap-datetimepicker.min.js"></script>
<script src="https://cdn.bootcss.com/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>
<script src="//ace.jeka.by/assets/js/jquery.validate.min.js"></script>
<!-- The basic File Upload plugin -->
<script src="/jQuery-File-Upload-master/js/jquery.fileupload.js"></script>
<!-- The File Upload processing plugin -->
<script src="/jQuery-File-Upload-master/js/jquery.fileupload-process.js"></script>
<!-- The File Upload validation plugin -->
<script src="/jQuery-File-Upload-master/js/jquery.fileupload-validate.js"></script>

<link href="https://cdn.bootcss.com/bootstrap-datetimepicker/4.17.47/css/bootstrap-datetimepicker.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.bootcss.com/jqueryui/1.12.1/jquery-ui.min.css"/>
<link rel="stylesheet" href="http://ace.jeka.by/assets/css/jquery-ui.custom.min.css"/>
<link rel="stylesheet" href="http://ace.jeka.by/assets/css/chosen.min.css"/>

<link href="http://cdnjs.cloudflare.com/ajax/libs/x-editable/1.5.1/bootstrap3-editable/css/bootstrap-editable.css" rel="stylesheet"/>
<link rel="stylesheet" href="http://ace.jeka.by/assets/css/jquery.gritter.min.css"/>
<%--<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">--%>
<link rel="stylesheet" href="../css/joinbuy.css"/>

<link rel="stylesheet" href="/jQuery-File-Upload-master/css/jquery.fileupload.css">

<script type="text/javascript">
    jQuery(function ($) {
        //var editor = new $.fn.dataTable.Editor({});
        //initiate dataTables plugin
        var myTable = $('#dynamic-table')
        //.wrap("<div class='dataTables_borderWrap' />")   //if you are applying horizontal scrolling (sScrollX)
            .DataTable({
                bAutoWidth: false,

                'columnDefs': [
                    {
                        "searchable": false, "orderable": false, data: 'recordID', className: 'text-center', "targets": 0, width: 20, render: function (data, type, row, meta) {
                            return meta.row + 1 + meta.settings._iDisplayStart;
                        }
                    },
                    {
                        "searchable": true, "orderable": false, title: '被查人姓名', className: 'text-center', "targets": 1
                    },
                    {"searchable": true, "orderable": false, title: '被查人身份证', className: 'text-center', "targets": 2},
                    {"searchable": false, "orderable": false, title: '被查人性别', className: 'text-center', "targets": 3},
                    {"searchable": true, "orderable": false, title: '被查人住址', className: 'text-center', "targets": 4},
                    {"searchable": true, "orderable": false, title: '比对时间', className: 'text-center', "targets": 5},
                    {"searchable": false, "orderable": false, title: '单位', className: 'text-center', "targets": 6},
                    {
                        'targets': 7, 'searchable': false, 'orderable': false, width: 85, data: 'recordID',
                        render: function (data, type, row, meta) {
                            return '<div class="hidden-sm hidden-xs action-buttons">' +
                                '<a class="green" href="#" data-affairID="{0}">'.format(data) +
                                '<i class="ace-icon fa fa-pencil bigger-130"></i>' +
                                '</a>' +
                                '<a class="black" href="#" data-affairID="{0}" data-goodsName="{1}">'.format(data, row["name"]) +
                                '<i class="ace-icon fa fa-trash-o bigger-130"></i>' +
                                '</a>' +
                                '<a class="red" href="#" data-affairID="{0}" data-goodsName="{1}">'.format(data, row["name"]) +
                                '<i class="ace-icon fa  fa-credit-card  bigger-130"></i>' +
                                '</a>' +
                                '</div>';
                        }
                    }],
                "aaSorting": [],
                language: {
                    url: 'https://cdn.datatables.net/plug-ins/1.10.16/i18n/Chinese.json'
                },
                "ajax": "appeal/listCheckRecord.jspx",

                select: {
                    style: 'single'
                }
            });
        myTable.on('order.dt search.dt', function () {
            myTable.column(0, {search: 'applied', order: 'applied'}).nodes().each(function (cell, i) {
                cell.innerHTML = i + 1;
            });
        }).draw();
        myTable.on('draw', function () {
            $('a.green').on('click', function (e) {
                e.preventDefault();
                showAffairDialog($(this).attr("data-affairID"));
            });
            $('a.black').on('click', function (e) {
                e.preventDefault();
                deleteAffair($(this).attr("data-affairID"), $(this).attr("data-goodsName"))
            });
        });

        var affairForm = $('#affairForm');
        affairForm.validate({
            errorElement: 'div',
            errorClass: 'help-block',
            focusInvalid: false,
            ignore: "",
            rules: {
                name: {required: true},
                togetherTimeString: {required: true}
            },

            highlight: function (e) {
                $(e).closest('.form-group').removeClass('has-info').addClass('has-error');
            },

            success: function (e) {
                $(e).closest('.form-group').removeClass('has-error');//.addClass('has-info');
                $(e).remove();
            },

            errorPlacement: function (error, element) {
                error.insertAfter(element.parent());
            },

            submitHandler: function (form) {
                //console.log(affairForm.serialize());// + "&productImage=" + av atar_ele.get(0).src);
                //console.log("form:" + form);
                $.ajax({
                    type: "POST",
                    url: "/appeal/saveAffair.jspx",
                    data: affairForm.serialize(),//+ "&productImage=" + av atar_ele.get(0).src,
                    contentType: "application/x-www-form-urlencoded",//http://www.cnblogs.com/yoyotl/p/5853206.html
                    cache: false,
                    success: function (response, textStatus) {
                        var result = JSON.parse(response);
                        if (!result.succeed) {
                            $("#errorText").text(result.errmsg);
                            $("#dialog-error").removeClass('hide').dialog({
                                modal: true,
                                width: 600,
                                title: result.title,
                                buttons: [{
                                    text: "确定", "class": "btn btn-primary btn-xs", click: function () {
                                        $(this).dialog("close");
                                    }
                                }]
                            });
                        } else {
                            myTable.ajax.reload();
                            $("#dialog-edit").dialog("close");
                        }
                    },
                    error: function (response, textStatus) {/*能够接收404,500等错误*/
                        $("#errorText").text(response.responseText.substr(0, 1000));
                        $("#dialog-error").removeClass('hide').dialog({
                            modal: true,
                            width: 600,
                            title: "请求状态码：" + response.status,//404，500等
                            buttons: [{
                                text: "确定", "class": "btn btn-primary btn-xs", click: function () {
                                    $(this).dialog("close");
                                }
                            }]
                        });
                    }
                });
            },
            invalidHandler: function (form) {
                console.log("invalidHandler");
            }
        });
        /*https://www.gyrocode.com/articles/jquery-datatables-checkboxes/*/

        //$.fn.dataTable.Buttons.swfPath = "components/datatables.net-buttons-swf/index.swf"; //in Ace demo ../components will be replaced by correct assets path
        $.fn.dataTable.Buttons.defaults.dom.container.className = 'dt-buttons btn-overlap btn-group btn-overlap';

        new $.fn.dataTable.Buttons(myTable, {
            buttons: [
                {
                    "text": "<i class='glyphicon glyphicon-list bigger-110 red'></i>导入 ",
                    "className": "btn btn-white btn-primary btn-bold"
                }
            ]
        });
        myTable.buttons().container().appendTo($('.tableTools-container'));


        var qrCodeTable = $("#qrCodeTable");


        var dataArray;

        /*保存save*/
        function uploadSingleFile(file, index) {
            /*console.log("file type:" + JSON.stringify(file.type));//三个都OK
            console.log("file size:" + JSON.stringify(file.size));
            console.log("filename:" + JSON.stringify(file.name));*/
            var formData = new FormData();
            formData.append("file", file);
            $.ajax({
                url: '/upload/singleUpload.jspx',
                type: 'POST',
                cache: false,
                data: formData,
                processData: false,
                contentType: false,
                dataType: "json",
                beforeSend: function () {
                    //uploading = true;
                },
                success: function (result) {
                    console.log("result.success:" + result.success);
                    console.log("result.files[0].url:" + result.files[0].url);
                    dataArray[index].uploaded = result.success;
                    dataArray[index].qrCodeUrl = result.files[0].url;
                },
                error: function (response, textStatus) {
                    return "";
                }
            });
        }
        var url = '/appeal/uploadCheckRecord.jspx',
            uploadButton = $('<button/>')
                .addClass('btn btn-primary')
                .prop('disabled', true)
                .text('Processing...')
                .on('click', function () {
                    var $this = $(this),
                        data = $this.data();
                    $this.off('click')
                        .text('Abort')
                        .on('click', function () {
                            $this.remove();
                            data.abort();
                        });
                    data.submit().always(function () {
                        $this.remove();
                    });
                });
        $('#fileupload').fileupload({
            url: url,
            dataType: 'json',
            autoUpload: false,
            acceptFileTypes: /(\.|\/)(xls|xlsx)$/i,
            maxFileSize: 999000,
            // Enable image resizing, except for Android and Opera,
            // which actually support image resizing, but fail to
            // send Blob objects via XHR requests:
            disableImageResize: /Android(?!.*Chrome)|Opera/.test(window.navigator.userAgent),
            previewMaxWidth: 100,
            previewMaxHeight: 100,
            previewCrop: true
        }).on('fileuploadadd', function (e, data) {
            data.context = $('<div/>').appendTo('#files');
            $.each(data.files, function (index, file) {
                var node = $('<p/>').append($('<span/>').text(file.name));
                if (!index) {
                    node.append('<br>').append(uploadButton.clone(true).data(data));
                }
                node.appendTo(data.context);
            });
        }).on('fileuploadprocessalways', function (e, data) {
            console.log(data.result);
            var index = data.index,
                file = data.files[index],
                node = $(data.context.children()[index]);
            if (file.preview) {
                node.prepend('<br>').prepend(file.preview);
            }
            if (file.error) {
                node.append('<br>').append($('<span class="text-danger"/>').text(file.error));
            }
            if (index + 1 === data.files.length) {
                data.context.find('button').text('上传').prop('disabled', !!data.files.error);
            }
        }).on('fileuploadprogressall', function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10);
            $('#progress .progress-bar').css(
                'width',
                progress + '%'
            );
        }).on('fileuploaddone', function (e, data) {
            /* console.log(" JSON.stringify(data):" + JSON.stringify(data));
             console.log(" JSON.stringify(e):" + JSON.stringify(e));*/
            $.each(data.result.files, function (index, file) {
                if (file.url) {
                    var link = $('<a>').attr('target', '_blank').prop('href', file.url);
                    $(data.context.children()[index]).wrap(link);
                } else if (file.error) {
                    var error = $('<span class="text-danger"/>').text(file.error);
                    $(data.context.children()[index]).append('<br>').append(error);
                }
            });
            //loadJson();
        }).on('fileuploadfail', function (e, data) {
            $.each(data.files, function (index) {
                var error = $('<span class="text-danger"/>').text('File upload failed.');
                $(data.context.children()[index]).append('<br>').append(error);
            });
        }).prop('disabled', !$.support.fileInput)
            .parent().addClass($.support.fileInput ? undefined : 'disabled');

        function deleteAffair(affairID, goodsName) {
            if (affairID === undefined) return;
            $('#name').text(goodsName);
            $("#dialog-delete").removeClass('hide').dialog({
                resizable: false,
                modal: true,
                title: "确认删除合买商品",
                title_html: true,
                buttons: [
                    {
                        html: "<i class='ace-icon fa  fa-trash bigger-110'></i>&nbsp;确定",
                        "class": "btn btn-danger btn-minier",
                        click: function () {
                            $.ajax({
                                type: "POST",
                                url: "/appeal/deleteAffair.jspx?affairID=" + affairID,
                                //contentType: "application/x-www-form-urlencoded",//http://www.cnblogs.com/yoyotl/p/5853206.html
                                cache: false,
                                success: function (response, textStatus) {
                                    var result = JSON.parse(response);
                                    if (result.succeed)
                                        myTable.ajax.reload();
                                    else
                                        showDialog("请求结果：" + result.succeed, response);
                                },
                                error: function (response, textStatus) {/*能够接收404,500等错误*/
                                    showDialog("请求状态码：" + response.status, response.responseText.substr(0, 1000));
                                    /* $("#errorText").text(response.responseText.substr(0, 1000));
                                     $("#dialog-error").removeClass('hide').dialog({
                                         modal: true,
                                         width: 600,
                                         title: "请求状态码：" + response.status,//404，500等
                                         buttons: [{
                                             text: "确定", "class": "btn btn-primary btn-xs", click: function () {
                                                 $(this).dialog("close");
                                             }
                                         }]
                                     });*/
                                }
                            });
                            $(this).dialog("close");
                        }
                    },
                    {
                        html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                        "class": "btn btn-minier",
                        click: function () {
                            $(this).dialog("close");
                        }
                    }
                ]
            });
        }

        $.gritter.options.class_name = 'gritter-center';


        //todo 统一到一个对话框
        function showDialog(title, content) {
            $("#errorText").text(content);
            $("#dialog-error").removeClass('hide').dialog({
                modal: true,
                width: 600,
                title: title,
                buttons: [{
                    text: "确定", "class": "btn btn-primary btn-xs", click: function () {
                        $(this).dialog("close");
                    }
                }]
            });
        }


        function showAffairDialog(affairID) {
            if ($("#affair option").size() === 0) {
                $.getJSON("/appeal/listAffair.jspx", function (result) {
                    if (result.iTotalRecords > 0) {
                        $.each(result.data, function (n, value) {
                            $('#affair').append('<option value="{0}"  selected="selected">{1}</option>'
                                .format(value.affairID, value.name));
                        });
                        $('#affair').val("");
                    }
                });
            }
            //affairForm[0].reset();
            if (affairID != null) {
                // var htmlobj = $.ajax({url: "appeal/showAffair.jspx?affairID=" + affairID, async: false});
                $.getJSON("appeal/showAffair.jspx?affairID=" + affairID, function (result) { //https://www.cnblogs.com/liuling/archive/2013/02/07/sdafsd.html
                    $("#form-name").val(result[0]["name"]);
                    $("#form-togetherTime").val(result[0]["togetherTime"]);
                    $("#form-place").val(result[0]["place"]);
                    $("#form-appealDepart").val(result[0]["appealDepart"]);
                    $("#form-receptionDepart").val(result[0]["receptionDepart"]);
                    $("#form-police").val(result[0]["police"]);
                    $("#form-general").val(result[0]["general"]);
                });
                $("#form-affairID").val(affairID);
            } else {  //用了reset(),就不用执行
                $("input[id^='form-'],#productImage").val("");
            }

            $("#dialog-edit").removeClass('hide').dialog({
                resizable: false,
                width: 450,
                height: 530,
                modal: true,
                title: affairID == null ? "增加事件" : "设置事件",
                title_html: true,
                buttons: [
                    {
                        html: "<i class='ace-icon fa  fa-pencil-square-o bigger-110'></i>&nbsp;保存",
                        "class": "btn btn-danger btn-minier",
                        click: function () {
                            //todo 直接从#form-closingTime获取时间的毫秒值!
                            if (affairForm.valid())
                                affairForm.submit();
                            //$(this).dialog("close");
                        }
                    }, {
                        html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                        "class": "btn btn-minier",
                        click: function () {
                            $(this).dialog("close");
                        }
                    }
                ]
            });
        }


        myTable.button(0).action(function (e, dt, button, config) {
            e.preventDefault();
            showAffairDialog(null);
        });


        if (!ace.vars['old_ie']) $('#form-togetherTime').datetimepicker({
            //format: 'MM/DD/YYYY h:mm:ss A',//use this option to display seconds
            //language: 'zh-CN',
            icons: {
                time: 'fa fa-clock-o',
                date: 'fa fa-calendar',
                up: 'fa fa-chevron-up',
                down: 'fa fa-chevron-down',
                previous: 'fa fa-chevron-left',
                next: 'fa fa-chevron-right',
                today: 'fa fa-arrows ',
                clear: 'fa fa-trash',
                close: 'fa fa-times'
            }
        }).next().on(ace.click_event, function () {
            $(this).prev().focus();
        }).on('show', function () {
            $(".datetimepicker").css("z-index", $("#dialog-edit").zIndex() + 1);
        }).on('hide', function () {
            console.log("hide");
        });

    })
</script>
<style>
    .fileinput-button {
        position: relative;
        display: inline-block;
        overflow: hidden;
    }

    .fileinput-button input {
        position: absolute;
        right: 0px;
        top: 0px;
        opacity: 0;
        -ms-filter: 'alpha(opacity=0)';
        font-size: 200px;
    }
</style>
<!-- #section:basics/content.breadcrumbs -->
<div class="breadcrumbs ace-save-state" id="breadcrumbs">
    <ul class="breadcrumb">
        <li>
            <i class="ace-icon fa fa-home home-icon"></i>
            <a href="/index.jspx">首页</a>
        </li>
        <li class="active">盘查录入</li>
    </ul><!-- /.breadcrumb -->


</div>

<!-- /section:basics/content.breadcrumbs -->
<div class="page-content">

    <div class="page-header">
        <h1>盘查录入 </h1>
    </div><!-- /.page-header -->

    <div class="row">
        <div class="col-xs-12">

            <div class="row">

                <div class="col-xs-12">
                    <div class="table-header">
                        事件 "全部列表"
                        <div class="pull-right tableTools-container"></div>
                    </div>

                    <!-- div.table-responsive -->

                    <!-- div.dataTables_borderWrap -->
                    <div>
                        <table id="dynamic-table" class="table table-striped table-bordered table-hover">
                        </table>
                    </div>
                </div>
            </div>


            <!-- PAGE CONTENT ENDS -->
        </div><!-- /.col -->
    </div><!-- /.row -->
    <div id="dialog-error" class="hide alert" title="提示">
        <p id="errorText">保存失败，请稍后再试，或与系统管理员联系。</p>
    </div>

    <div id="dialog-delete" class="hide">
        <div class="alert alert-info bigger-110">
            永久删除 <span id="name" class="red"></span> ，不可恢复！
        </div>

        <div class="space-6"></div>

        <p class="bigger-110 bolder center grey">
            <i class="icon-hand-right blue bigger-120"></i>
            确认吗？
        </p>
    </div>
    <div id="dialog-edit" class="hide">
        <form class="form-horizontal" role="form" id="affairForm">
            <div class="col-xs-11">
                <input type="hidden" id="form-affairID" name="affairID"/>

                <div class="form-group">
                    <label>聚集事件 ：</label>
                    <select id="affair" class="nav-search-input"></select>
                </div>

                <div class="row">
                    <div class="col-xs-8 center-block ">
                        <span class="btn btn-success fileinput-button">
                            <i class="glyphicon glyphicon-plus"></i>
                            <span>选择盘查excel...</span>
                            <input id="fileupload" type="file" name="file" multiple>
                        </span>
                        <br>
                        <br>
                        <!-- The global progress bar -->
                        <div id="progress" class="progress">
                            <div class="progress-bar progress-bar-success"></div>
                        </div>
                        <!-- The container for the uploaded files -->
                        <div id="files" class="files"></div>
                    </div>
                </div>


            </div>
        </form>
    </div><!-- #dialog-edit -->

    <div id="qrcode-edit" class="modal fade" tabindex="-1">
        <input id="affairID" type="hidden"/>
        <input id="goodsPrice" type="hidden"/>
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header no-padding">
                    <div class="table-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                            <span class="white">&times;</span>
                        </button>
                        <span id="qrCodeDialog-title">设置支付二维码</span>
                    </div>
                </div>

                <div class="modal-body no-padding">

                    <table id="qrCodeTable" class="table table-striped table-bordered table-hover no-margin-bottom no-border-top">
                        <thead>
                        <tr>
                            <th class="hidden"></th>
                            <th class="col-xs-1">数量</th>
                            <th class="col-xs-2">金额</th>
                            <th class="col-xs-8">文件名</th>
                            <th class="col-xs-1"></th>
                        </tr>
                        </thead>

                        <tbody>
                        <%-- <tr>
                             <td class="hidden"></td>
                             <td align="center">任意</td>
                             <td align="right">任意</td>
                             <td><input type="file" hidden name="upfile" id="upfile"/></td>
                             <td></td>
                         </tr>--%>
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer no-margin-top">
                    <button class="btn btn-sm  btn-primary pull-left" id="addQroCodeBtn">
                        <i class="ace-icon glyphicon glyphicon-plus"></i>
                        增加
                    </button>
                    <button class="btn btn-sm btn-warning pull-right" id="saveQrCodeBtn">
                        <i class="ace-icon fa fa-save"></i>
                        提交
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>
    <%--<div id="dialog-alert" title="警告" class="hidden">
        <p>未选择足够的付款二维码！</p>
    </div>--%>
    <div id="dialog-null" class="hidden">
        <div id="dialog-content"></div>
    </div>
</div>
<!-- /.page-content -->