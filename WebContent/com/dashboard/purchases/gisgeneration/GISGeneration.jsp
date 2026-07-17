<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GatewayERP(i)</title>
    <link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .myButtons {
            -moz-box-shadow: inset 0px -1px 3px 0px #91b8b3;
            -webkit-box-shadow: inset 0px -1px 3px 0px #91b8b3;
            box-shadow: inset 0px -1px 3px 0px #91b8b3;
            background: -webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
            background: -moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
            background: -webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
            background: -o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
            background: -ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
            background: linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
            filter: progid: DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c', GradientType=0);
            background-color: #768d87;
            border: 1px solid #566963;
            display: inline-block;
            cursor: pointer;
            color: #ffffff;
            font-size: 8pt;
            padding: 3px 17px;
            text-decoration: none;
            text-shadow: 0px -1px 0px #2b665e;
        }
        
        .myButtons:hover {
            background: -webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
            background: -moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
            background: -webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
            background: -o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
            background: -ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
            background: linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
            filter: progid: DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87', GradientType=0);
            background-color: #6c7c7c;
        }
        
        .myButtons:active {
            position: relative;
            top: 1px;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function() {

            $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
            $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

            $("#uptodate").jqxDateTimeInput({
                width: '125px',
                height: '15px',
                formatString: "dd.MM.yyyy",
                value:new Date()
            });
        });

        function funExportBtn() {
            
        }
		function setValues(){
			if($('#msg').val()!=''){
				$.messager.alert('Warning',$('#msg').val());
			}
		}
        function funreload(event) {
			var uptodate =$('#uptodate').jqxDateTimeInput('val');
            var branch = document.getElementById("cmbbranch").value;
			$("#overlay, #PleaseWait").show();
            $("#gismasterdiv").load("gisMasterGrid.jsp?branch=" + branch + "&uptodate=" + uptodate + "&id=1");
        }

        function funcleardata() {
            $('#uptodate').jqxDateTimeInput('setDate',new Date());
			$('#gisMasterGrid,#gisDetailGrid').jqxGrid('clear');
        }
        
        function funCreateGoodsIssue(){
        	var selectedrows=$('#gisDetailGrid').jqxGrid('selectedrowindexes');
        	if(selectedrows.length==0){
        		$.messager.alert('Warning','Please select valid documents');
        		return false;
        	}
        	var detailarray=new Array();
        	var total=0.0;
       		for(var i=0;i<selectedrows.length;i++){
       			var jobcarddocno=$('#gisDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'jobcarddocno');
       			if(jobcarddocno=="" || jobcarddocno=="undefined" || jobcarddocno==null || typeof(jobcarddocno)=="undefined" || jobcarddocno=="0"){
       				$.messager.alert('Warning','Job card not available');
       				return false;
       			}
      			var psrno=$('#gisDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'psrno');
       			var prodoc=$('#gisDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'prodoc');
       			var unitdocno=$('#gisDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'unitdocno');
       			var qty=$('#gisDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'qty');
       			var saveqty=$('#gisDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'saveqty');
       			var checktype=$('#gisDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'checktype');
       			var specid=$('#gisDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'specid');
       			var foc=$('#gisDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'foc');
       			var costprice=$('#gisDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'taxamount');
       			var savecostprice=$('#gisDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'taxamount');
       			total=parseFloat(total)+parseFloat(savecostprice);
       			detailarray.push(psrno+" :: "+prodoc+" :: "+unitdocno+" :: "+qty+" :: "+saveqty+" :: "+checktype+" :: "+specid+" :: "+foc+" :: "+costprice+" :: "+savecostprice+" :: "+jobcarddocno);	
       		}
       		$('#griddata').val(detailarray);
       		document.getElementById("mode").value="A";
        	document.getElementById("frmGoodsIssueGeneration").submit();
        	
		}
    </script>
</head>

<body onload="getBranch();setValues();">
    <div id="mainBG" class="homeContent" data-type="background">
        <div class='hidden-scrollbar'>
        	<form id="frmGoodsIssueGeneration" action="saveGoodsIssueGeneration">
        		<table width="100%">
	                <tr>
	                    <td width="20%">
	                        <fieldset style="background: #ECF8E0;">
	                            <table width="100%">
	                                <jsp:include page="../../heading.jsp"></jsp:include>
	                                <tr>
	                                    <td align="right">
	                                        <label class="branch">Upto</label>
	                                    </td>
	                                    <td align="left">
	                                        <div id='uptodate' name='uptodate' value='<s:property value="uptodate"/>'></div>
	                                    </td>
	                                </tr>
	                                <tr><td colspan="2" align="center"><button type="button" class="myButton" id="btncreategis" onclick="funCreateGoodsIssue();">Create Goods Issue Note</button></td></tr>
	                                <tr><td colspan="2">&nbsp;</td></tr>
	                                <tr><td colspan="2">&nbsp;</td></tr>
	                                <tr><td colspan="2">&nbsp;</td></tr>
	                                <tr><td colspan="2">&nbsp;</td></tr>
	                                <tr><td colspan="2">&nbsp;</td></tr>
	                                <tr>
	                                    <td colspan="2" align="center">
	                                        <input type="button" class="myButtons" name="clear" id="clear" value="Clear" onclick="funcleardata()">
	                                    </td>
	                                </tr>
	
	                                <tr>
	                                    <td colspan="2">
	                                        <div id='paychaaaaa' style="width: 100% ; align:right; height: 150px;"></div>
	                                    </td>
	                                </tr>
	                            </table>
	                        </fieldset>
	                        <input type="hidden" id="acno" name="acno" value='<s:property value="acno"/>'>
	                    </td>
	                    <td width="80%">
	                        <table width="100%">
	                            <tr>
	                                <td>
	                                    <div id="gismasterdiv">
	                                        <jsp:include page="gisMasterGrid.jsp"></jsp:include>
	                                    </div>
	                                    <div id="gisdetaildiv">
	                                        <jsp:include page="gisDetailGrid.jsp"></jsp:include>
	                                    </div>
	                                </td>
	                            </tr>
	                        </table>
	                </tr>
	            </table>
	            <input type="hidden" name="griddata" id="griddata" value='<s:property value="griddata"/>'>
	            <input type="hidden" name="pivdocno" id="pivdocno" value='<s:property value="pivdocno"/>'>
	            <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
        	</form>
            

        </div>
        <div id="accountSearchwindow">
            <div></div>
        </div>
    </div>
</body>

</html>