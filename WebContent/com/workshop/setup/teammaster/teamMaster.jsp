<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<style>
/* =========================================================
SCOPED UI: Modern Layout (Matches Client Master)
========================================================= */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
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

/* Layout Utilities */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Middle Section Panels */
.modern-ui .middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 20px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
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
    font-size: 14px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
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
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript">
    
    $(document).ready(function() {
        /* Set jqxDateTimeInput to 24px height with modern UI theme */
        $("#date").jqxDateTimeInput({ width : '125px', height : 24, formatString : "dd.MM.yyyy", theme: 'energyblue' }); 
        
        /* force internal alignment AFTER render */
        setTimeout(function () {
             $("#date").find("input").css({
                 "margin-top": "0px",
                 "line-height": "24px",
                 "font-size": "12px", 
                 "font-family": "Arial, sans-serif", 
                 "padding": "0 6px", 
                 "box-sizing":"border-box"
             });
             $("#date").find(".jqx-action-button").css({
                 "top": "0px",
                 "height": "24px"
             });
        }, 0);
    
        $('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
        $('#employeeDetailsWindow').jqxWindow('close');
        
        $('#userDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Team-User Link Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
        $('#userDetailsWindow').jqxWindow('close');
        
        $('#txtteamuserlinkname').dblclick(function(){
            $('#userDetailsWindow').jqxWindow('open');
            userSearchContent('userDetailsSearch.jsp?id=0');
        });
        
        document.getElementById("formdet").innerText="Team Master(WTM)";
        document.getElementById("formdetail").value="Team Master";
        document.getElementById("formdetailcode").value="WTM";
        window.parent.formCode.value="WTM";
        window.parent.formName.value="Team Master";
    });
    
    function employeeSearchContent(url) {
        $('#employeeDetailsWindow').jqxWindow('open');
        $.get(url).done(function (data) {
        $('#employeeDetailsWindow').jqxWindow('setContent', data);
        $('#employeeDetailsWindow').jqxWindow('bringToFront');
    }); 
    }
    
    function userSearchContent(url) {
        $('#userDetailsWindow').jqxWindow('open');
        $.get(url).done(function (data) {
        $('#userDetailsWindow').jqxWindow('setContent', data);
        $('#userDetailsWindow').jqxWindow('bringToFront');
    }); 
    }
    
    function getTeamUserLink(event){
        var x= event.keyCode;
        if(x==114){
             $('#userDetailsWindow').jqxWindow('open');
             userSearchContent('userDetailsSearch.jsp?id=0');
        }
        else{}
        }
    
    function getTeamUserLink(rownindex){
        $('#userDetailsWindow').jqxWindow('open');
        userSearchContent('userDetailsSearch.jsp?id=1&rownindex='+rownindex); 
    }
    
    function getemployee(rownindex){
      $('#employeeDetailsWindow').jqxWindow('open');
      employeeSearchContent('employeeDetailsSearch.jsp?rownindex='+rownindex); 
    }
    
    function funReadOnly() {
         $('#frmServiceteam input').attr('readonly', true);
         $('#frmServiceteam input').attr('disabled', true);
         $('#date').jqxDateTimeInput({ disabled: true});
         $('#docno').attr('disabled', false);
         $("#serviceteamGrid").jqxGrid('disabled',true);
    }
    
    function funRemoveReadOnly() {
        $('#frmServiceteam input').attr('readonly', false);
        $('#frmServiceteam input').attr('disabled', false);
        $('#docno').attr('readonly', true);
        $('#txtteamuserlinkname').attr('readonly', true);
        
         $('#date').jqxDateTimeInput({ disabled: false}); 
         $("#serviceteamGrid").jqxGrid('disabled',false);
         if ($("#mode").val() == "A") {
             $('#date').val(new Date());
             $("#serviceteamGrid").jqxGrid('clear');
             $("#serviceteamGrid").jqxGrid('addrow', null, {});
           }
         if($('#mode').val()=='E'){
            $("#serviceteamGrid").jqxGrid('addrow', null, {});
         }   
        
    }
    
    function setValues() {
        document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
        funSetlabel();
        
        if(document.getElementById("ismultiemp").value==1)
        {
            document.getElementById("ismemp").checked=true;
        }
        if(document.getElementById("ismultiemp").value==0)
        {
            document.getElementById("ismemp").checked=false;
        }
        
        var docVal1 = document.getElementById("docno").value;
        
        if(docVal1>0)
            {
             $("#searviceteamdiv").load("serviceteamGrid.jsp?docno="+docVal1);
            }
        
         if($('#msg').val()!=""){
               $.messager.alert('Message',$('#msg').val());
              }
         if ($('#hidcmbavbranch').val() != null && $('#hidcmbavbranch').val() != "") {   
                $('#cmbavbranch').val($('#hidcmbavbranch').val());
            }
    }

     function funFocus()
    {
        document.getElementById("txtgpcode").focus();
            
    }
   
     function funNotify(){
            
            if(document.getElementById("ismemp").checked==true)
                {
                    document.getElementById("ismultiemp").value=1;
                }
            if(document.getElementById("ismemp").checked==false)
                {
                    document.getElementById("ismultiemp").value=0;
                }
            
            var rows = $("#serviceteamGrid").jqxGrid('getrows');
            $('#serteamgridlen').val(rows.length);
          
           for(var i=0 ; i < rows.length ; i++){
        
            newTextBox = $(document.createElement("input"))
               .attr("type", "hidden")
               .attr("id", "test"+i)
               .attr("name", "test"+i)
               .attr("hidden", "true"); 
         
            newTextBox.val(rows[i].empid+"::"+rows[i].teamuserlinkid+" :: ");
            newTextBox.appendTo('form');
            
           }
            
            return 1;
     }
        
  function fungridchange(){
      $("#serviceteamGrid").jqxGrid('addrow', null, {});
  }
  
  function funSearchLoad(){
        changeContent('masterSearch.jsp', $('#window'));
  }
  
  function getBranch() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                var salesagentItems = items[0].split(",");
                
                var salesagentIdItems = items[1].split(",");
                var optionssalesagent;
                optionssalesagent = '<option value="a" selected>All</option>';  
                for (var i = 0; i < salesagentItems.length; i++) {
                    optionssalesagent += '<option value="' + salesagentIdItems[i] + '">'
                            + salesagentItems[i] + '</option>';
                }
                $("select#cmbavbranch").html(optionssalesagent);
            } else {
            }
        }
        x.open("GET", "getBranch.jsp", true);   
        x.send();
    }
</script>
</head>
<body onLoad="getBranch();setValues();"> 
<div id="mainBG" class="homeContent" data-type="background"> 
<form id="frmServiceteam" action="saveTeamMaster" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" />

<div class='modern-ui hidden-scrollbar'>
    <div id="errormsg"></div>

    <div class="middle-panel" style="background: #fdfdfd;">
        <span class="middle-panel-title">Team Master Details</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id="date" name="date" value='<s:property value="date"/>'></div>
            </div>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
            <input type="text" name="docno" id="docno" style="width:150px;" value='<s:property value="docno"/>' readonly tabindex="-1">
        </div>

        <div class="field-row">
            <label style="display:flex; align-items:center; gap:5px; font-size:12px; font-weight:bold; color:#444; cursor:pointer;">
                <input type="checkbox" name="ismemp" id="ismemp" onchange="fungridchange()"> Multiple Employees
            </label>
            
            <label class="lbl-right" style="width:120px; margin-left:15px;">Team-User Link</label>
            <div class="input-search-container" style="width:150px;">
                <input type="text" name="txtteamuserlinkname" id="txtteamuserlinkname" placeholder="Press F3" onKeyDown="getTeamUserLink(event);" value='<s:property value="txtteamuserlinkname"/>'>
                <svg class="magnifier-icon" onclick="$('#txtteamuserlinkname').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="hidden" name="txtteamuserlinkid" id="txtteamuserlinkid" value='<s:property value="txtteamuserlinkid"/>'>

            <label class="lbl-right" style="width:80px; margin-left:15px;">Group Code</label>
            <input type="text" name="txtgpcode" id="txtgpcode" style="width:150px;" value='<s:property value="txtgpcode"/>'>
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Description</label>
            <input type="text" id="txtdesc" name="txtdesc" style="flex:1;" value='<s:property value="txtdesc"/>'>
            
            <label class="lbl-right" style="width:80px; margin-left:15px;">Av.Branch</label>
            <select id="cmbavbranch" name="cmbavbranch" style="width:150px;" value='<s:property value="cmbbranch"/>'>
                <option value="">--Select--</option>
            </select>
        </div>
    </div>

    <!-- Service Team Grid -->
    <div id="searviceteamdiv" style="margin-bottom: 15px;">
        <jsp:include page="serviceteamGrid.jsp"></jsp:include>
    </div>

    <!-- Hidden Fields -->
    <div style="display:none;">
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
        <input type="hidden" id="hidcmbavbranch" name="hidcmbavbranch" value='<s:property value="hidcmbavbranch"/>'/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="ismultiemp" name="ismultiemp" value='<s:property value="ismultiemp"/>'/>
        <input type="hidden" id="serteamgridlen" name="serteamgridlen" value='<s:property value="serteamgridlen"/>'/>
    </div>
</div>
</form>

<div id="employeeDetailsWindow">
   <div></div><div></div>
</div>
<div id="userDetailsWindow">
   <div></div><div></div>
</div>

</div>
</body>
</html>