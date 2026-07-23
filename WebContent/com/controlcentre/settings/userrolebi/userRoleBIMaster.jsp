<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

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
             $('#userRoleDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'User-Role Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
             $('#userRoleDetailsWindow').jqxWindow('close');
        });
        
        function userRoleSearchContent(url) {
            $('#userRoleDetailsWindow').jqxWindow('open');
            $.get(url).done(function (data) {
            $('#userRoleDetailsWindow').jqxWindow('setContent', data);
            $('#userRoleDetailsWindow').jqxWindow('bringToFront');
        }); 
        }
        
        function funReadOnly(){
            $('#frmUserRoleBIMaster input').attr('readonly', true );
            $("#jqxUserRoleBI").jqxGrid({ disabled: true});
        }
        
        function funRemoveReadOnly(){
            $('#frmUserRoleBIMaster input').attr('readonly', false );
            $('#txtrolename').attr('readonly', true);
            $('#docno').attr('readonly', true);
            $("#jqxUserRoleBI").jqxGrid({ disabled: false});
            
            if ($("#mode").val() == "A") {
                $("#userRoleBIDiv").load("userRoleBIGrid.jsp");  
            }

        }
        
        function funSearchLoad(){
             changeContent('ubiMainSearch.jsp');  
         }
            
        function funChkButton() {
                /* funReset(); */
        }
         
        function funFocus(){
            document.getElementById("txtrolename").focus();             
        }
        
        function funNotify(){   
            /* User Role Grid Saving */
            var rows = $("#jqxUserRoleBI").jqxGrid('getrows');
             var length=0;
             for(var i=0 ; i < rows.length ; i++){
                var chk=rows[i].mno;
                if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
                    newTextBox = $(document.createElement("input"))
                    .attr("type", "hidden")
                    .attr("id", "test"+length)
                    .attr("name", "test"+length);
                    length=length+1;
                    
                newTextBox.val(rows[i].mno+"::"+rows[i].master+":: "+rows[i].dno+":: "+rows[i].detail+":: "+rows[i].permission+":: "+rows[i].email+":: "+rows[i].excel);
                newTextBox.appendTo('form');
                }
              }
            $('#gridlength').val(length);
             /* User Role Grid Saving Ends*/ 
                
             return 1;
            } 
          
          function setValues(){
              
              if($('#msg').val()!=""){
                   $.messager.alert('Message',$('#msg').val());
                  }
              
              if(document.getElementById("formdet")) {
                  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
              }
              funSetlabel();
              
              var indexVal = document.getElementById("docno").value;
              if(indexVal>0){
                  $("#userRoleBIDiv").load("userRoleBIGrid.jsp?roleid="+indexVal);
              }
              
            }
          
          function funSearchdblclick(){
              $('#txtrolename').dblclick(function(){
                  userRoleSearchContent('userRoleSearchGrid.jsp');
              });
          }
          
          function getRole(event){
          var x= event.keyCode;
          if(x==114){
              userRoleSearchContent('userRoleSearchGrid.jsp');
          }
          else{}
          }
        
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmUserRoleBIMaster" action="saveUserRoleBIMaster" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>
    <div id="errormsg"></div>

    <div class="middle-panel">
        <span class="middle-panel-title">User Role Info</span>
        
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Role</label>
            <div class="input-search-container" style="width:250px;">
                <input type="text" id="txtrolename" name="txtrolename" placeholder="Press F3" ondblclick="funSearchdblclick();" onkeydown="getRole(event);" value='<s:property value="txtrolename"/>'/>
                <svg class="magnifier-icon" onclick="$('#txtrolename').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="hidden" id="txtroleid" name="txtroleid" value='<s:property value="txtroleid"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:15px;">Doc No.</label>
            <input type="text" id="docno" name="txtuserrolebidocno" style="width:150px;" value='<s:property value="txtuserrolebidocno"/>' tabindex="-1" readonly/>
        </div>
    </div>

    <!-- User Role Grid -->
    <div class="middle-panel" style="margin-bottom: 15px;">
        <span class="middle-panel-title">Role BI Permissions</span>
        <div id="userRoleBIDiv">
            <jsp:include page="userRoleBIGrid.jsp"></jsp:include>
        </div>
    </div>

    <!-- Hidden Fields -->
    <div style="display:none;">
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" id="gridlength" name="gridlength"/>
    </div>
</div>
</form>

<div id="userRoleDetailsWindow">
    <div></div><div></div>
</div> 

</div>
</body>
</html>