<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../includes.jsp"></jsp:include>

<style>
/* =========================================================
SCOPED UI: Modern Layout (Plain White Background)
========================================================= */
body {
    background: #ffffff;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #ffffff;
    border-radius: 16px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    border: 1px solid #e2e8f0;
    box-shadow: none;
}

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 5px 15px;
    box-sizing: border-box;
    width: 100%;
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui input[type="email"],
.modern-ui select { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui input[type="email"]:focus,
.modern-ui select:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled,
.modern-ui select:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

.modern-ui input[type="checkbox"] {
    width: 14px !important;
    height: 14px !important;
    margin: 0;
    cursor: pointer;
}

/* Layout Utilities - Tightened Spacing */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
    justify-content: flex-start;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Middle Section Panels - Reduced Padding */
.modern-ui .middle-panel {
    border: 1px solid #e2e8f0; 
    padding: 18px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 12px;
    margin-top: 12px;
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -12px;
    left: 10px; 
    background: #ffffff; 
    padding: 0 8px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 13px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
    display: flex;
    align-items: center;
}

/* Custom UI Buttons matching 24px height */
.modern-ui .myButton {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 12px;
    font-family: Arial, sans-serif;
    font-size: 11px;
    font-weight: bold;
    border-radius: 3px;
    cursor: pointer;
    text-shadow: none;
    transition: all 0.2s;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    border: none;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    white-space: nowrap;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 4px;
}
.modern-ui .myButton:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

/* Search Icon Wrapper */
.modern-ui .input-search-container {
    position: relative;
    display: flex;
}
.modern-ui .input-search-container input {
    padding-right: 25px !important;
}
.modern-ui .magnifier-icon {
    position: absolute;
    right: 6px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
.modern-ui .magnifier-icon:hover { color: #2563eb; }

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 120px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

form label.error { color:red; font-weight:bold; }
#errormsg { color:red; font-weight:bold; text-align:center; margin-bottom: 10px; }
</style>

<script type="text/javascript">
    $(document).ready(function() {
         // Date Setup
         $("#jqxIpglDate").jqxDateTimeInput({ width: '100%', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
         
         /* force internal alignment AFTER render */
         setTimeout(function () {
             $("#jqxIpglDate").find("input").css({
                 "margin-top": "0px",
                 "line-height": "24px",
                 "font-size": "12px", 
                 "font-family": "Arial, sans-serif", 
                 "padding": "0 6px", 
                 "box-sizing":"border-box"
             });
             $("#jqxIpglDate").find(".jqx-action-button").css({
                 "top": "0px",
                 "height": "24px"
             });
         }, 0);
         
        $("#btnEdit").attr('disabled', true );
         $("#btnPrint").attr('disabled', true );
         $("#btnExcel").attr('disabled', true );
         $("#btnDelete").attr('disabled', true );
         $("#btnCancel").attr('disabled', true );
         $("#btnSearch").attr('disabled', true );
         $("#btnClose").attr('disabled', true );
    });
    
    
   function  funReadOnly(){
        $('#frmGuideLine input').attr('disabled', true );
        $('#frmGuideLine textarea').attr('disabled', true );
        $('#frmGuideLine select').attr('disabled', true);
        $('#jqxgthree').jqxGrid({ disabled: true});
        $('#jqxgDesc').jqxGrid({ disabled: true});
        $('#jqxgtwo').jqxGrid({ disabled: true});
        $('#jqxMenuGrid').jqxGrid({ disabled: true});
         $('#mode').attr('disabled', false);
         $('#formdetailcode').attr('disabled', false);
    }
     
     function funSearchLoad(){
        changeContent('masterSearch.jsp', $('#window'));
    }
     
     function funRemoveReadOnly(){
         $('#frmGuideLine input').attr('disabled', false );
            $('#frmGuideLine textarea').attr('disabled', false );
            $('#frmGuideLine select').attr('disabled', false);
            $('#jqxgthree').jqxGrid({ disabled: false});
            $('#jqxgDesc').jqxGrid({ disabled: false});
            $('#jqxgtwo').jqxGrid({ disabled: false});
            $('#jqxMenuGrid').jqxGrid({ disabled: false});
        $('#descGrid').load("descGrid.jsp?doctype=0");
            $('#gtwoGrid').load("gtwoGrid.jsp?doctype=0");
            $('#gthreeGrid').load("gthreeGrid.jsp?doctype=0");
     }
    
    function funUpdate(){
          if(document.getElementById("btnUpdate").value=="Update")
           {
             document.getElementById("btnUpdate").value="Save";
             return 0;
           }
          else if(document.getElementById("btnUpdate").value=="Save"){
                 $('#btnSave').mousedown();
               }
      }

    function funFocus(){
         document.getElementById("txtrefno").focus();  
     }
    
    function funAdd(){
        var jobtype=document.getElementById("txtjobtype").value;
        var jobstatus=document.getElementById("txtjobstatus").value;
        var statusid=document.getElementById("jobstatusid").value;
        var description=document.getElementById("txtdescription").value;
        var mandatory=document.getElementById("chckmandatory").value;
        var date=document.getElementById("jqxIpglDate").value;
        
        if(jobstatus==""){
            document.getElementById("errormsg").innerText="Select a job Status";
            return 0;
        }
        
        if(description==""){
            document.getElementById("errormsg").innerText="Enter Description For selected for process";
            return 0;
        }
        
          var x = new XMLHttpRequest();
          x.onreadystatechange = function() {
           if (x.readyState == 4 && x.status == 200) {
            var item=x.responseText.trim();
            
            if(item>0)
        {
        $.messager.alert('Message',"Added Successfully");
        $('#descGrid').load("descGrid.jsp?statusid="+document.getElementById("jobstatusid").value+"&jobtype="+document.getElementById("txtjobtype").value);
            document.getElementById("txtdescription").value="";
            document.getElementById("errormsg").innerText="";
            $('#chckmandatory').attr('checked', false);
            
            return  true;
        }
        else
         {
        $.messager.alert('Message',"Failed");
        return  false;
         }
            
           } else {
           }
          }
          x.open("GET","guidlineinsert.jsp?jobtype="+jobtype+"&jobstatus="+jobstatus+"&statusid="+statusid+"&description="+description+"&mandatory="+mandatory+"&date="+date, true);
          x.send();  
         }
    
function funUpdate(){
        
        var jobstatus=document.getElementById("txtjobstatus").value;
        var statusid=document.getElementById("jobstatusid").value;
        var srno=document.getElementById("is_pglinesrno").value;
        var description=document.getElementById("txtdescription").value;
        var mandatory=document.getElementById("chckmandatory").value;
        
        if(jobstatus==""){
            document.getElementById("errormsg").innerText="Select a job Status";
            return 0;
        }
        
        if(description==""){
            document.getElementById("errormsg").innerText="Enter Description For selected for process";
            return 0;
        }
          var x = new XMLHttpRequest();
          x.onreadystatechange = function() {
           if (x.readyState == 4 && x.status == 200) {
            var item=x.responseText.trim();
            
            if(item>0)
        {
        $.messager.alert('Message',"Updated Successfully");
        $('#descGrid').load("descGrid.jsp?statusid="+document.getElementById("jobstatusid").value+"&jobtype="+document.getElementById("txtjobtype").value);
            document.getElementById("jobstatusid").value="";
            document.getElementById("txtdescription").value="";
            document.getElementById("errormsg").innerText="";
            $('#chckmandatory').attr('checked', false);
            return  true;
        }
        else
         {
        $.messager.alert('Message',"Failed");
        return  false;
         }
            
           } else {
           }
          }
          x.open("GET","guidlineupdate.jsp?statusid="+statusid+"&description='"+description+"'&srno="+srno+"&mandatory="+mandatory, true);
          x.send();  
         }


function funDelete(){
    
    var jobstatus=document.getElementById("txtjobstatus").value;
    var statusid=document.getElementById("jobstatusid").value;
    var srno=document.getElementById("is_pglinesrno").value;
    var description=document.getElementById("txtdescription").value;
    
    if(jobstatus==""){
        document.getElementById("errormsg").innerText="Select a job Status";
        return 0;
    }
    
    if(description==""){
        document.getElementById("errormsg").innerText="Select a description to delete";
        return 0;
    }
    
      var x = new XMLHttpRequest();
      x.onreadystatechange = function() {
       if (x.readyState == 4 && x.status == 200) {
        var item=x.responseText.trim();
        
        if(item>0)
        {
        $.messager.alert('Message',"Deleted Successfully");
        $('#descGrid').load("descGrid.jsp?statusid="+document.getElementById("jobstatusid").value+"&jobtype="+document.getElementById("txtjobtype").value);
        document.getElementById("jobstatusid").value="";
        document.getElementById("txtdescription").value="";
        document.getElementById("errormsg").innerText="";
        $('#chckmandatory').attr('checked', false);
            return  true;
        }
    else
     {
    $.messager.alert('Message',"Failed");
    return  false;
     }
            
       } else {
       }
      }
      x.open("GET","guidlinedelete.jsp?statusid="+statusid+"&srno="+srno, true);
      x.send();  
     }
    
function funNotify(){   
     var rows = $("#jqxgDesc").jqxGrid('getrows');
        var len=0;
       for(var i=0;i<rows.length;i++){
        var description= $.trim(rows[i].description);
        if(description.trim()!="" && typeof(description)!="undefined" && typeof(description)!="NaN" )
            {
            newTextBox = $(document.createElement("input"))
               .attr("type", "hidden")
               .attr("id", "test"+len)
               .attr("name", "test"+len);
               
       newTextBox.val(rows[i].description);
       newTextBox.appendTo('form'); 
       len=len+1;
             }
       }
       $('#descgridlen').val(len);
       
       var rows = $("#jqxgtwo").jqxGrid('getrows');
        var len=0;
       for(var i=0;i<rows.length;i++){
        var fieldname= $.trim(rows[i].fieldname);
        if(fieldname.trim()!="" && typeof(fieldname)!="undefined" && typeof(fieldname)!="NaN" )
            {
            newTextBox = $(document.createElement("input"))
               .attr("type", "hidden")
               .attr("id", "test2"+len)
               .attr("name", "test2"+len);
               
       newTextBox.val(rows[i].fieldname+" :: "+rows[i].description+"");
       newTextBox.appendTo('form'); 
       len=len+1;
             }
       }
       $('#fieldgridlen').val(len);
       
       var rows = $("#jqxgthree").jqxGrid('getrows');
        var len=0;
       for(var i=0;i<rows.length;i++){
        var notes= $.trim(rows[i].notes);
        if(notes.trim()!="" && typeof(notes)!="undefined" && typeof(notes)!="NaN" )
            {
            newTextBox = $(document.createElement("input"))
               .attr("type", "hidden")
               .attr("id", "test3"+len)
               .attr("name", "test3"+len);
               
       newTextBox.val(rows[i].notes);
       newTextBox.appendTo('form'); 
       len=len+1;
             }
       }
       $('#notegridlen').val(len);
       
       return 1;
}

function setValues() {
      var doctype=document.getElementById("txtdoctype").value;
      if(doctype!="")
          {
  var indexVal1 = document.getElementById("txtdoctype").value;
  var rdoc_type=indexVal1.replace(/ /g, "%20");
 
  $('#descGrid').load("descGrid.jsp?doctype="+rdoc_type);
  $('#gtwoGrid').load("gtwoGrid.jsp?doctype="+rdoc_type);
  $('#gthreeGrid').load("gthreeGrid.jsp?doctype="+rdoc_type);
          }
      
         if($('#hidjqxIpglDate').val()){
            $("#jqxIpglDate").jqxDateTimeInput('val', $('#hidjqxIpglDate').val());
        } 
        
       if($('#msg').val()!=""){
           $.messager.alert('Message',$('#msg').val());
          }
}

</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmGuideLine" action="guideline" autocomplete="off">

<jsp:include page="../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>
    <div id="errormsg"></div>

    <!-- Main Guideline Info -->
    <div class="middle-panel" style="margin-bottom: 15px;">
        <span class="middle-panel-title">Guideline Configuration</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="flex:1; max-width:125px;">
                <div id="jqxIpglDate" name="jqxIpglDate" value='<s:property value="jqxIpglDate"/>'></div>
            </div>
            <input type="hidden" id="hidjqxIpglDate" name="hidjqxIpglDate" value='<s:property value="hidjqxIpglDate"/>'/>
            
            <label class="lbl-right" style="width:60px; margin-left:15px;">Ref No</label>
            <input type="text" id="txtrefno" name="txtrefno" style="width:150px;" value='<s:property value="txtrefno"/>'/>
            
            <label class="lbl-right" style="width:60px; margin-left:auto;">Doc No</label>
            <input type="text" id="docno" name="docno" readonly="true" style="width:120px;" value='<s:property value="docno"/>' tabindex="-1"/>
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Menu Details</label>
            <input type="text" id="txtdoctype" name="txtdoctype" readonly="true" style="width:150px;" value='<s:property value="txtdoctype"/>'/>
            
            <input type="text" id="txtmenuname" name="txtmenuname" readonly="true" style="flex:1; margin-left:8px;" value='<s:property value="txtmenuname"/>' tabindex="-1"/>
        </div>
    </div>

    <!-- Status / Grid Section -->
    <div class="middle-panel" style="margin-bottom: 15px;">
        <span class="middle-panel-title">Status Details</span>
        
        <div style="display:flex; gap:15px;">
            <!-- Left Side Menu Grid -->
            <div style="flex: 0 0 30%;">
                <div id="menuGrid">
                    <jsp:include page="menuGrid.jsp"></jsp:include>
                </div>
            </div>
            
            <!-- Right Side Configuration Grids -->
            <div style="flex: 1; display:flex; flex-direction:column; gap:15px;">
                <div id="descGrid">
                    <jsp:include page="descGrid.jsp"></jsp:include>
                </div>
                <div id="gtwoGrid">
                    <jsp:include page="gtwoGrid.jsp"></jsp:include>
                </div>
                <div id="gthreeGrid">
                    <jsp:include page="gthreeGrid.jsp"></jsp:include>
                </div>
            </div>
        </div>
    </div>

    <!-- Hidden Fields -->
    <div style="display:none;">
        <input type="hidden" id="descgridlen" name="descgridlen" value='<s:property value="descgridlen"/>'/>
        <input type="hidden" id="fieldgridlen" name="fieldgridlen" value='<s:property value="fieldgridlen"/>'/>
        <input type="hidden" id="notegridlen" name="notegridlen" value='<s:property value="notegridlen"/>'/>
        <input type="hidden" id="txtmenuid" name="txtmenuid" value='<s:property value="txtmenuid"/>'/>
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
    </div>
</div>
</form>
    
</div>
</body>
</html>