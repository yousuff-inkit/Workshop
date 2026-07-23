<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<s:head/>
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
.modern-ui input[type="password"],
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
.modern-ui input[type="password"]:focus,
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
    $(document).ready(function () {  
        // Date Setup
        $("#jqxUserMasterDate").jqxDateTimeInput({ width: '100%', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
        
        /* force internal alignment AFTER render */
        setTimeout(function () {
             $("#jqxUserMasterDate").find("input").css({
                 "margin-top": "0px",
                 "line-height": "24px",
                 "font-size": "12px", 
                 "font-family": "Arial, sans-serif", 
                 "padding": "0 6px", 
                 "box-sizing":"border-box"
             });
             $("#jqxUserMasterDate").find(".jqx-action-button").css({
                 "top": "0px",
                 "height": "24px"
             });
        }, 0);
        
        $('#roleDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'User Role Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
        $('#roleDetailsWindow').jqxWindow('close');
        
        $('#txtpasswordconfirm').on('keyup', function () {
            if ($(this).val() == $('#txtuserpassword').val()) {
                $('#message').html('Matching').css('color', 'green');
            } else $('#message').html('Not Matching').css('color', 'red');
        });
           
        $('#txtbrole').dblclick(function(){
            $('#roleDetailsWindow').jqxWindow('open');
            roleSearchContent('userRoleSearchGrid.jsp?', $('#roleDetailsWindow')); 
        });
      });
     
      function roleSearchContent(url) {
          $('#roleDetailsWindow').jqxWindow('open');
       $.get(url).done(function (data) {
       $('#roleDetailsWindow').jqxWindow('setContent', data);
       $('#roleDetailsWindow').jqxWindow('bringToFront');
      }); 
      }
     
        function funReadOnly(){
            $('#frmUserMaster input').attr('readonly', true );
            $('#frmUserMaster select').attr('disabled', true );
            $('#jqxUserMasterDate').jqxDateTimeInput({ disabled: true});
        }
        
        function funFocus(){
            $('#jqxUserMasterDate').jqxDateTimeInput('focus'); 
        }
        
        function funRemoveReadOnly(){
            $('#frmUserMaster input').attr('readonly', false );
            $('#frmUserMaster select').attr('disabled', false );
            $('#jqxUserMasterDate').jqxDateTimeInput({ disabled: false});
            $('#docno').attr('readonly', true);
            
            $('#txtbrole').attr('readonly', true);
            if($('#mode').val()=="A") {
                 $('#jqxUserMasterDate').val(new Date());
             $("#userMasterDiv").load("userMasterGrid.jsp");  
            }
            
            if ($("#mode").val() == "E") {
                if(document.getElementById("permissionval").value==1) {
                   $("#jqxUserMaster").jqxGrid({ disabled: false});   
                }
            }
            
            if ($("#mode").val() == "D") {
                $('#jqxUserMasterDate').jqxDateTimeInput({ disabled: false});
            }
            
             getLang();
        }

        function getLang() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    items = items.split('####');
                    var langItems = items[0].split(",");
                    var optionslang = '';
                    for (var i = 0; i < langItems.length; i++) {
                        optionslang += '<option value="' + langItems[i] + '">'
                                + langItems[i] + '</option>';
                    }
                    
                    $("select#cmblanguage").html(optionslang);
                    
                    if ($('#langval').val()!="") {
                        var aa=$('#langval').val().trim();
                        $('#cmblanguage').val(aa) ;
                    }
                }
            }
            x.open("GET", "getLang.jsp", true);
            x.send();
        }
        
        function funSearchLoad() {
         changeContent('masterSearchuser.jsp'); 
        }
        
        function checkUserid() {
            var userid=document.getElementById("txtuser").value;
            var masterdoc=document.getElementById("docno").value;
        
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    
                     if(parseInt(items)>0) {
                         document.getElementById("useridchk").value=1;                      
                            document.getElementById("errormsg").innerText="User ID Already Exists";
                            return  false;
                        }
                         else {
                             document.getElementById("useridchk").value="";     
                            document.getElementById("errormsg").innerText="";
                            return  true;
                         }
                 }
            }
            x.open("GET", "checkUserid.jsp?userid="+userid+"&masterdoc="+masterdoc, true);
            x.send();
        }
        
        function checkUsername() {
            var username=document.getElementById("txtusername").value;
            var masterdocs=document.getElementById("docno").value;
        
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    
                     if(parseInt(items)>0) {
                         document.getElementById("usernamechk").value=1;        
                            document.getElementById("errormsg").innerText="User Name Already Exists";
                            return  false;
                        }
                         else {
                             document.getElementById("usernamechk").value="";       
                            document.getElementById("errormsg").innerText="";
                            return  true;
                         }
                 }
            }
            x.open("GET", "checkUsername.jsp?username="+username+"&masterdocs="+masterdocs, true);
            x.send();
        }
        
        $(function(){
            $('#frmUserMaster').validate({
                     rules: {
                         txtuser:{
                             required:true,maxlength:10
                         },
                         txtusername:{
                             required:true,maxlength:30
                         },
                         txtuserpassword:{
                             required:true,maxlength:100
                         },
                         txtpasswordconfirm:{
                             required:true
                         },
                         txtusermail:"required"
                     },
                     messages: {
                         txtuser:{
                             required:" *required",maxlength:"max 10 chars"
                         },
                         txtusername:{
                             required:"*required",maxlength:" max 30 chars"
                         },
                         txtuserpassword:{
                              required:" *required",maxlength:" max 100 chars"
                          },
                          txtpasswordconfirm:{
                              required:" *required"
                                 },
                                 txtusermail:" *Enter Valid Email",          
                     }
            });
            });
        
          function funNotify(){
           var useridchk= document.getElementById("useridchk").value;
             if(parseInt(useridchk)==1) {
                 document.getElementById("errormsg").innerText="User ID Already Exists";
                 document.getElementById("txtuser").focus();
                    return  0;
                 }
              var usernamechk= document.getElementById("usernamechk").value;
             if(parseInt(usernamechk)==1) {
                 document.getElementById("errormsg").innerText="User Name Already Exists";
                 document.getElementById("txtusername").focus();
                    return  0;  
                 }
             var levelss= document.getElementById("levels").value;
             if(levelss=="") {
                 document.getElementById("errormsg").innerText="Select Discount Level";
                 document.getElementById("levels").focus();
                    return  0;  
                 }
             var rolelevel= document.getElementById("txtbrole").value;
             if(rolelevel=="") {
                 document.getElementById("errormsg").innerText="Select Role";
                 document.getElementById("txtbrole").focus();
                    return  0;  
                 }
             if($('#txtuserpassword').val()!=$('#txtpasswordconfirm').val()) {
                 document.getElementById("errormsg").innerText="Password Is Not Matching";
                    return  0;  
                 }
            
                if($('#cmpermission').val()==1) {               
               var z=0;
               var rows = $("#jqxUserMaster").jqxGrid('getrows');                    
                   
               var selectedRecords = new Array();
               var selectedrows=$("#jqxUserMaster").jqxGrid('selectedrowindexes');
              
              if(selectedrows.length==0){
               $.messager.alert('Warning','Select Branch & Company.');
               return false;
              }
          
              $('#existusermaster').val(selectedrows.length);
              for (var i = 0; i < rows.length; i++) {
              for(var j=0;j<selectedrows.length;j++){
               if(selectedrows[j]==i){
                newTextBox = $(document.createElement("input"))
                   .attr("type", "hidden")
                   .attr("id", "test"+z)
                   .attr("name", "test"+z);
                
               newTextBox.val(rows[i].brhid+"::"+rows[i].compid);
               newTextBox.appendTo('form');
               z++;
               }
              }
           }
            
                   }
        
            
                return 1;
        } 
          
    
           function getURole(event){
                  var x= event.keyCode;
                  if(x==114){
                   roleSearchContent('userRoleSearchGrid.jsp');
                  }
                  else{
                   }
                  }
         function fungriddis()
         {
           if($('#cmpermission').val()==1) {
               $("#jqxUserMaster").jqxGrid({ disabled: false});   
               $('#jqxUserMaster').jqxGrid({ selectionmode: 'checkbox'}); 
           }
           else {
               $("#jqxUserMaster").jqxGrid({ disabled: true}); 
               $('#jqxUserMaster').jqxGrid({ selectionmode: 'checkbox'}); 
           }
         }
         
       
         function checkvals() {
           if($('#permissionval').val()!="") {
          $('#cmpermission').val($('#permissionval').val());
          }
           if($('#hidelevels').val()!="") {
          $('#levels').val($('#hidelevels').val());
          }
         }

         
        function setValues() {
            if($('#hidjqxUserMasterDate').val()){
                $("#jqxUserMasterDate").jqxDateTimeInput('val', $('#hidjqxUserMasterDate').val());
            }
            var docnumber=document.getElementById("docno").value;
            
            if(parseInt(docnumber)>0) { 
                 $("#userMasterDiv").load("userMasterGrid.jsp?docno="+docnumber);
            }  
            
            if($('#msg').val()!=""){
                   $.messager.alert('Message',$('#msg').val());
            }
            
             getLang();
            checkvals();
            if(document.getElementById("formdet")) {
                document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
            }
            funSetlabel();
        }

        
</script>
</head>
<body onload="setValues();getLang();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmUserMaster" action="saveUserMaster" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>
    <div id="errormsg"></div>

    <div class="middle-panel">
        <span class="middle-panel-title">User Master Info</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:120px;">Date</label>
            <div style="width: 125px;">
                <div id='jqxUserMasterDate' name='jqxUserMasterDate' value='<s:property value="jqxUserMasterDate"/>'></div>
            </div>
            <input type="hidden" id="hidjqxUserMasterDate" name="hidjqxUserMasterDate" value='<s:property value="hidjqxUserMasterDate"/>'/>
            
            <label class="lbl-right" style="width:120px; margin-left:auto;">Doc No</label>
            <input type="text" id="docno" name="docno" style="width:150px;" tabindex="-1" value='<s:property value="docno"/>' readonly/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:120px;">User ID</label>
            <input type="text" id="txtuser" name="txtuser" style="width:150px;" placeholder="Enter user ID" value='<s:property value="txtuser"/>' onblur="checkUserid()"/>
            
            <label class="lbl-right" style="width:100px; margin-left:15px;">User Name</label>
            <input type="text" id="txtusername" name="txtusername" placeholder="Enter user Name" style="width:250px;" value='<s:property value="txtusername"/>' onblur="checkUsername()"/>
            
            <label class="lbl-right" style="width:100px; margin-left:15px;">Discount Level</label>
            <select id="levels" name="levels" style="width:120px;" value='<s:property value="levels"/>' >
                <option value="" >--Select--</option> 
                <option value="1">Level 1</option>
                <option value="2">Level 2</option>
                <option value="3">Level 3</option>
            </select>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:120px;">Role</label>
            <div class="input-search-container" style="width:250px;">
                <input type="text" id="txtbrole" name="txtbrole" placeholder="Press F3 to Search" value='<s:property value="txtbrole"/>' onkeydown="getURole(event);" />
                <svg class="magnifier-icon" onclick="$('#txtbrole').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="hidden" id="txtroleid" name="txtroleid" value='<s:property value="txtroleid"/>'/>
            
            <label class="lbl-right" style="width:100px; margin-left:15px;">Language</label>
            <select id="cmblanguage" name="cmblanguage" style="width:120px;" value='<s:property value="cmblanguage"/>'>
            </select>
            <input type="hidden" id="hidcmblanguage" name="hidcmblanguage" value='<s:property value="hidcmblanguage"/>'/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:120px;">Email</label>
            <input type="email" id="txtusermail" name="txtusermail" style="width:250px;" placeholder="Email" value='<s:property value="txtusermail"/>' />
            
            <label class="lbl-right" style="width:100px; margin-left:15px;">Permission</label>
            <select id="cmpermission" name="cmpermission" style="width:120px;" value='<s:property value="cmpermission"/>' onchange="fungriddis()">
                <option value="0">All Branch</option>
                <option value="1">Selected Branch</option>
            </select>
            <input type="hidden" id="hidcmpermission" name="hidcmpermission" value='<s:property value="hidcmpermission"/>'/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:120px;">E-mail Password</label>
            <input type="password" id="txtmailpswd" name="txtmailpswd" style="width:250px;" placeholder="Email Password" value='<s:property value="txtmailpswd"/>' />
            
            <label class="lbl-right" style="width:100px; margin-left:15px;">Signature</label>
            <input type="text" id="txtmailsign" name="txtmailsign" placeholder="Email Signature" style="width:250px;" value='<s:property value="txtmailsign"/>' >
        </div> 

        <div class="field-row">
            <label class="lbl-right" style="width:120px;">E-mail Host</label>
            <input type="text" id="txtmailhost" name="txtmailhost" style="width:250px;" placeholder="Email Host" value='<s:property value="txtmailhost"/>' />
            
            <label class="lbl-right" style="width:100px; margin-left:15px;">E-mail Port</label>
            <input type="text" id="txtmailport" name="txtmailport" placeholder="Email Port" style="width:120px;" value='<s:property value="txtmailport"/>' >
        </div>  

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:120px;">Password</label>
            <input type="password" id="txtuserpassword" name="txtuserpassword" style="width:150px;" placeholder="Enter Password" value='<s:property value="txtuserpassword"/>'/>
            
            <label class="lbl-right" style="width:100px; margin-left:15px;">Confirm</label>
            <input type="password" id="txtpasswordconfirm" name="txtpasswordconfirm" style="width:150px;" placeholder="Enter Confirm Password" value='<s:property value="txtpasswordconfirm"/>'/>
            <span style="font-weight: bold; font-size:12px; margin-left:8px;" id="message"></span>
        </div>
    </div>

    <!-- User Master Grid -->
    <div class="middle-panel" style="margin-bottom: 15px;">
        <span class="middle-panel-title">Master Selection</span>
        <div id="userMasterDiv" align="center">
            <jsp:include page="userMasterGrid.jsp"></jsp:include>
        </div>
    </div>

    <!-- Hidden Fields -->
    <div style="display:none;">
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" id="useridchk" name="useridchk" value='<s:property value="useridchk"/>'/>
        <input type="hidden" id="usernamechk" name="usernamechk" value='<s:property value="usernamechk"/>'/>
        <input type="hidden" id="langval" name="langval" value='<s:property value="langval"/>'/>
        <input type="hidden" id="permissionval" name="permissionval" value='<s:property value="permissionval"/>'/> 
        <input type="hidden" id="existusermaster" name="existusermaster" value='<s:property value="existusermaster"/>'/>
        <input type="hidden" id="hidelevels" name="hidelevels" value='<s:property value="hidelevels"/>'/>
    </div>
</form>

<div id="roleDetailsWindow">
 <div></div><div></div>
</div>

</div>
</body>
</html>