 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<style>
.formfont {
	font: 9px Tahoma;
	color: #404040;
	background: #E0ECF8;
	overflow: hidden;
}
</style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

	<script type="text/javascript">
	$(document).ready(function () {
		 $("#dr_DOB").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	 
	 
	 $( "#btnok_client" ).click(function() {
  	   
        	var rows = $("#jqxclientsearch").jqxGrid('selectedrowindexes');
        if(rows!=""){
     	 	if(document.getElementById("searchdetails").value==""){
	           		document.getElementById("searchdetails").value="Client";	
	           		document.getElementById("client").value="Client";
	           	}
	           	else{
	           		document.getElementById("searchdetails").value+="\n\nClient";
	           		document.getElementById("client").value+="\nClient";
	           	}
        }
       
        	
        	document.getElementById("hidclient").value="";
        	
        	for(var i=0;i<rows.length;i++){
        		var dummy=$('#jqxclientsearch').jqxGrid('getcellvalue',rows[i],'refname');
        		var docno=$('#jqxclientsearch').jqxGrid('getcellvalue',rows[i],'cldocno');
        		document.getElementById("searchdetails").value+="\n"+dummy;
        		document.getElementById("client").value+="\n"+dummy;
        		if(i==0){
        			document.getElementById("hidclient").value=docno;
        		}
        		else{
        			document.getElementById("hidclient").value+=","+docno;
        		}
        	}
        	$('#clientToWindow').jqxWindow('close');
	});


$( "#btncancel_client" ).click(function() {
		$('#clientToWindow').jqxWindow('close');
	});
	
	
	}); 

 	function loadSearch() {
 		
 		var clname=document.getElementById("Cl_name").value;
 		var mob=document.getElementById("Cl_mob").value;
 		var lcno=document.getElementById("dr_Licence").value;
 		var passno=document.getElementById("dr_Passport").value;
 		var nation=document.getElementById("dr_Nation").value;
 		var dob=document.getElementById("dr_DOB").value;
		var branch=document.getElementById("cmbbranch").value;
		getdata(clname,mob,lcno,passno,nation,dob,branch);

	}	
	function getdata(clname,mob,lcno,passno,nation,dob,branch){
		
		 $("#refreshdiv").load('clientSearchGrid.jsp?clname='+clname+'&mob='+mob+'&lcno='+lcno+'&passno='+passno+'&nation='+nation+'&dob='+dob+'&branch='+branch);
	
		}

	</script>
<style>
/* =========================================================
   SCOPED UI: Segoe UI Font & Clean White Search Panel
========================================================= */
body{
    margin:0;
    background:#fff;
    font-family:'Segoe UI','Roboto','Arial',sans-serif;
}

.modern-ui{
    font-size:12px;
    color:#333;
    padding:10px;
    width:100%;
    box-sizing:border-box;
}

/* Master Input Styles */
.modern-ui input[type="text"],
.modern-ui select{
    width:100%;
    height:24px !important;
    border:1px solid #BDBDBD;
    border-radius:3px;
    padding:2px 6px;
    box-sizing:border-box;
    font-size:12px;
    font-family:'Segoe UI','Roboto','Arial',sans-serif;
    background:#fff;
    color:#333;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus{
    border-color:#007bff;
    outline:none;
}

/* Search Panel */
.modern-ui .search-panel{
    background:#fff;
    border:1px solid #BDBDBD;
    border-radius:4px;
    padding:12px 10px;
    margin-bottom:10px;
    width:100%;
    box-sizing:border-box;
}

/* Table */
.modern-ui table{
    width:100%;
    border-collapse:separate;
    border-spacing:8px 10px;
    table-layout:fixed;
}

.modern-ui td{
    vertical-align:middle;
}

.modern-ui .lbl-right{
    text-align:right;
    font-size:12px;
    font-weight:600;
    color:#222;
    white-space:nowrap;
    padding-right:6px;
}

/* Buttons */
.modern-ui .myButton{
    height:26px;
    padding:0 20px;
    background:#0056b3;
    color:#fff;
    border:none;
    border-radius:3px;
    cursor:pointer;
    font-size:12px;
    font-weight:600;
    font-family:'Segoe UI','Roboto','Arial',sans-serif;
    transition:.2s;
}

.modern-ui .myButton:hover{
    background:#004494;
}

/* Grid */
.modern-ui .grid-container{
    border:1px solid #BDBDBD;
    background:#fff;
    overflow:hidden;
    width:100%;
}
</style>

<body style="background:#fff;margin:0;">

<div id="search" class="modern-ui">

    <div class="search-panel">

        <table border="0" cellspacing="0" cellpadding="0">

            <colgroup>
                <col width="10%">
                <col width="22%">
                <col width="10%">
                <col width="22%">
                <col width="10%">
                <col width="22%">
                <col width="14%">
            </colgroup>

            <!-- Row 1 -->
            <tr>

                <td class="lbl-right">Name</td>

                <td colspan="5">
                    <input type="text"
                           name="Cl_name"
                           id="Cl_name"
                           value='<s:property value="Cl_name"/>'>
                </td>

                <td align="center">
                    <input type="button"
                           name="btnrasearch"
                           id="btnrasearch"
                           class="myButton"
                           value="Search"
                           onclick="loadSearch();">
                </td>

            </tr>

            <!-- Row 2 -->
            <tr>

                <td class="lbl-right">License#</td>

                <td>
                    <input type="text"
                           name="dr_Licence"
                           id="dr_Licence"
                           value='<s:property value="dr_Licence"/>'>
                </td>

                <td class="lbl-right">Passport#</td>

                <td>
                    <input type="text"
                           name="dr_Passport"
                           id="dr_Passport"
                           value='<s:property value="dr_Passport"/>'>
                </td>

                <td class="lbl-right">Nationality</td>

                <td>
                    <input type="text"
                           id="dr_Nation"
                           name="dr_Nation"
                           value='<s:property value="dr_Nation"/>'>
                </td>

                <td align="center">
                    <button type="button"
                            id="btnok_client"
                            name="btnok"
                            class="myButton">
                        OK
                    </button>
                </td>

            </tr>

            <!-- Row 3 -->
            <tr>

                <td class="lbl-right">Mobile</td>

                <td>
                    <input type="text"
                           name="Cl_mob"
                           id="Cl_mob"
                           value='<s:property value="Cl_mob"/>'>
                </td>

                <td class="lbl-right">DOB</td>

                <td>
                    <div id="dr_DOB"
                         name="dr_DOB"
                         value='<s:property value="dr_DOB"/>'></div>

                    <input type="hidden"
                           name="hiddr_DOB"
                           id="hiddr_DOB"
                           value='<s:property value="hiddr_DOB"/>'>
                </td>

                <td></td>
                <td></td>

                <td align="center">
                    <button type="button"
                            id="btncancel_client"
                            name="btncancel"
                            class="myButton">
                        Cancel
                    </button>
                </td>

            </tr>

        </table>

    </div>

    <div class="grid-container">

        <div id="refreshdiv">
            <jsp:include page="clientSearchGrid.jsp"></jsp:include>
        </div>

    </div>

</div>

</body>
</html>