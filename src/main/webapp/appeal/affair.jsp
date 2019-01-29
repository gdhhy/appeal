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

<link href="https://cdn.bootcss.com/bootstrap-datetimepicker/4.17.47/css/bootstrap-datetimepicker.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.bootcss.com/jqueryui/1.12.1/jquery-ui.min.css"/>
<link rel="stylesheet" href="http://ace.jeka.by/assets/css/jquery-ui.custom.min.css"/>
<link rel="stylesheet" href="http://ace.jeka.by/assets/css/chosen.min.css"/>

<link href="http://cdnjs.cloudflare.com/ajax/libs/x-editable/1.5.1/bootstrap3-editable/css/bootstrap-editable.css" rel="stylesheet"/>
<link rel="stylesheet" href="http://ace.jeka.by/assets/css/jquery.gritter.min.css"/>
<%--<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">--%>
<link rel="stylesheet" href="../css/joinbuy.css"/>

<script type="text/javascript">
    jQuery(function ($) {
        //var editor = new $.fn.dataTable.Editor({});
        //initiate dataTables plugin
        var myTable = $('#dynamic-table')
        //.wrap("<div class='dataTables_borderWrap' />")   //if you are applying horizontal scrolling (sScrollX)
            .DataTable({
                bAutoWidth: false,
                "columns": [
                    {"data": "affairID"},
                    {"data": "name", "sClass": "center"},
                    {"data": "place", "sClass": "center"},
                    {"data": "togetherTime", "sClass": "center"},
                    {"data": "appealDepart", "sClass": "center"},
                    /*{"data": "receptionDepart", "sClass": "center"},*/
                    {"data": "police", "sClass": "center"},
                    {"data": "createTime", "sClass": "center"} //,
                    /*  {"data": "createUserID", "sClass": "center"},
                    {"data": "createTime", "sClass": "center"}*/
                ],

                'columnDefs': [
                    {
                        "searchable": false, "orderable": false, className: 'text-center', "targets": 0, width: 20, render: function (data, type, row, meta) {
                            return meta.row + 1 + meta.settings._iDisplayStart;
                        }
                    },
                    {
                        "searchable": true, "orderable": false, title: '聚集名', className: 'text-center', "targets": 1
                    },
                    {"searchable": true, "orderable": false, title: '场所', className: 'text-center', "targets": 2},
                    {"searchable": false, "orderable": false, title: '聚集时间', className: 'text-center', "targets": 3},
                    {"searchable": true, "orderable": false, title: '诉求部门', className: 'text-center', "targets": 4},
                    /*{"searchable": true, "orderable": false, title: '接待部门', className: 'text-center', "targets": 5},*/
                    {"searchable": true, "orderable": false, title: '公安部门', className: 'text-center', "targets": 5},
                    /*{"searchable": true, "orderable": false, title: '创建人', className: 'text-center', "targets": 7},*/
                    {"searchable": false, "orderable": false, title: '创建时间', className: 'text-center', "targets": 6},
                    {
                        'targets': 7, 'searchable': false, 'orderable': false, width: 60, data: 'affairID',
                        render: function (data, type, row, meta) {
                            return '<div class="hidden-sm hidden-xs action-buttons">' +
                                '<a class="green" href="#" data-affairID="{0}">'.format(data) +
                                '<i class="ace-icon fa fa-pencil bigger-130"></i>' +
                                '</a>' +
                                '<a class="black" href="#" data-affairID="{0}" data-goodsName="{1}">'.format(data, row["name"]) +
                                '<i class="ace-icon fa fa-trash-o bigger-130"></i>' +
                                '</a>' +
                                '</div>';
                        }
                    }],
                "aaSorting": [],
                language: {
                    url: 'https://cdn.datatables.net/plug-ins/1.10.16/i18n/Chinese.json'
                },
                "ajax": "appeal/listAffair.jspx",

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
                    "text": "<i class='glyphicon glyphicon-plus  bigger-110 red'></i>新增 ",
                    "className": "btn btn-white btn-primary btn-bold"
                }
            ]
        });
        myTable.buttons().container().appendTo($('.tableTools-container'));

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
<!-- #section:basics/content.breadcrumbs -->
<div class="breadcrumbs ace-save-state" id="breadcrumbs">
    <ul class="breadcrumb">
        <li>
            <i class="ace-icon fa fa-home home-icon"></i>
            <a href="/index.jspx">首页</a>
        </li>
        <li class="active">上访事件管理</li>
    </ul><!-- /.breadcrumb -->
</div>

<!-- /section:basics/content.breadcrumbs -->
<div class="page-content">

    <div class="page-header">
        <h1>上访事件管理 </h1>
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
                    <label class="col-sm-3 control-label no-padding-right" for="form-name">聚集名称 </label>

                    <div class="col-sm-9">
                        <div class="input-group">
                            <input type="text" id="form-name" name="name" placeholder="聚集名称" class="col-xs-10 col-sm-12"/>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label no-padding-right" for="form-togetherTime">聚集时间</label>
                    <div class="col-sm-7">
                        <!-- #section:plugins/date-time.datepicker -->
                        <div class="input-group">
                            <input class="form-control col-xs-10 col-sm-12" name="togetherTime" id="form-togetherTime"
                                   data-date-format="YYYY-MM-DD HH:mm"/>
                            <span class="input-group-addon"><i class="fa fa-clock-o bigger-110"></i></span>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label no-padding-right" for="form-place">场所 </label>

                    <div class="col-sm-9">
                        <div class="input-group">
                            <input type="text" id="form-place" placeholder="场所" name="place" class="col-xs-10 col-sm-12"/>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label no-padding-right" for="form-appealDepart">申诉部门 </label>

                    <div class="col-sm-9">
                        <input type="text" id="form-appealDepart" placeholder="接待部门" name="appealDepart" class="col-xs-10 col-sm-12"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label no-padding-right" for="form-receptionDepart">接待部门 </label>

                    <div class="col-sm-9">
                        <input type="text" id="form-receptionDepart" name="receptionDepart" placeholder="接待部门" class="col-xs-10 col-sm-12"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label no-padding-right" for="form-police">处理公安 </label>

                    <div class="col-sm-9">
                        <input type="text" id="form-police" name="police" placeholder="处理公安" class="col-xs-10 col-sm-12"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-3 control-label no-padding-right" for="form-general">大致情况 </label>
                    <div class="col-sm-9">
                        <textarea rows="4" id="form-general" placeholder="大致情况" name="general" class="col-sm-12" maxlength="1023"></textarea>
                    </div>
                </div>


            </div>
        </form>
    </div>

    <%--<div id="dialog-alert" title="警告" class="hidden">
        <p>未选择足够的付款二维码！</p>
    </div>--%>
    <div id="dialog-null" class="hidden">
        <div id="dialog-content"></div>
    </div>
</div>
<!-- /.page-content -->