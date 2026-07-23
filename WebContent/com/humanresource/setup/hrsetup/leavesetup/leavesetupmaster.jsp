<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath(); %>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../../includes.jsp"></jsp:include>

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

.modern-ui .myButton-delete {
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
    background: linear-gradient(135deg, #dc2626 0%, #b91c1c 100%);
    color: #ffffff;
    white-space: nowrap;
}
.modern-ui .myButton-delete:hover { background: linear-gradient(135deg, #b91c1c 0%, #991b1b 100%); }


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

/* Grid Wrappers */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

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

/* Legacy Bounce Animation (Retained for visual parity if requested) */
.bounce {
    color: #f35626;
    background-image: -webkit-linear-gradient(92deg,#f35626,#feab3a);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    -webkit-animation: hue 60s infinite linear,bounce 2s infinite; 
}
@-webkit-keyframes bounce {
  0%, 20%, 50%, 80%, 100% { transform: translateX(0); }
  40% { transform: translateX(-30px); }
  60% { transform: translateX(-15px); }
} 
@-webkit-keyframes hue {
  from { -webkit-filter: hue-rotate(0deg); }
  to { -webkit-filter: hue-rotate(-360deg); }
}
</style>

<script type="text/javascript">

	$(document).ready(function () {   
		
	    document.getElementById("formdet").innerText="Leave Setup(LSP)";
		document.getElementById("formdetail").value="Leave Setup";
		document.getElementById("formdetailcode").value="LSP";
		window.parent.formCode.value="LSP";
		window.parent.formName.value="Leave Setup";
		document.getElementById("showlabel").innerText="";
		
		$('#refSearchwindow').jqxWindow({ width: '60%', height: '62%',  maxHeight: '75%' ,maxWidth: '60%' , title: 'Ref No Search' ,position: { x: 150, y: 60 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#refSearchwindow').jqxWindow('close');
		
		$('#btnCreate').attr('disabled', true);
		$('#btnDelete').attr('disabled', true);
		$('#btnSearch').attr('disabled', true);
		$('#btnEdit').attr('disabled', true);
		
		$('#refno').dblclick(function(){
            $('#refSearchwindow').jqxWindow('open');
            refnoSearchContent('refmastersearch.jsp?');
		});   
		    
    });
	
	function funSearchLoad(){}

	function refnoSearchContent(url) {
        $.get(url).done(function (data) {
            $('#refSearchwindow').jqxWindow('open');
            $('#refSearchwindow').jqxWindow('setContent', data);
		}); 
	}
	 
    function gethrsetup(event){
        var x= event.keyCode;
        if(x==114){
            $('#refSearchwindow').jqxWindow('open');
            refnoSearchContent('refmastersearch.jsp?');    
        }
    }
      
	function funReadOnly() {
		$('#frmleavesetup input').attr('readonly', true);
		$('#savebtn').attr('disabled', true);
		$('#deltbtn').attr('disabled', true);
	}
	
	function funRemoveReadOnly() {
		$('#frmleavesetup input').attr('readonly', false);
		$('#docno').attr('readonly', true);
	}
 
	function setValues() {
        if(document.getElementById("newmode").value=='Saved') {
            var leaveid=document.getElementById("leaveid").value;
            var refno= document.getElementById("refno").value;
            $("#lsetup1").load("leavesetupgrid.jsp?docno="+refno);
            
            var disdata="hide";
            
            $("#lsetup2").load("condtiongrid.jsp?docno="+refno+"&leaveid="+leaveid+"&disdata="+disdata);
            document.getElementById("showlabel").innerText=document.getElementById("hidshowlabel").value;
            
            $.messager.alert('Message', '  Record successfully Updated ');
            funReadOnly();
        } else if(document.getElementById("newmode").value=='notSaved') {
            $.messager.alert('Message', '  Not Updated ');
        } 
	}
	
    function funNotify(){}
	 
    function fundel() {
        var leavetype="";
        var rows = $("#leavesetupgrid").jqxGrid('getrows');      
        for(var i=0;i<rows.length;i++){
            if(parseInt(rows[i].checkclick)==1){
                leavetype=rows[i].leavetype; 
            }
        }
        
        $.messager.confirm('Message', 'Do you want to delete all records of '+leavetype, function(r){
            if(r==false) {
                return false; 
            } else{
                var leaveid="";
                var rows = $("#leavesetupgrid").jqxGrid('getrows');      
                for(var i=0;i<rows.length;i++){
                    if(parseInt(rows[i].checkclick)==1){
                        leaveid=rows[i].ldocno; 
                    }
                }
                fundeldata(leaveid,leavetype);
            }
        });
    }

    function fundeldata(leaveid,leavetype) {
        var refno= document.getElementById("refno").value;
        var x=new XMLHttpRequest();
        x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
                var items= x.responseText;
                if(parseInt(items)>0) {
                        $.messager.alert('Message', 'Record Successfully Deleted Leave Type - '+leavetype);
                        document.getElementById("newmode").value="";
                        var leaveid=document.getElementById("leaveid").value;
                        var refno= document.getElementById("refno").value;
                        
                        $("#lsetup1").load("leavesetupgrid.jsp?docno="+refno);
                        var disdata="hide";
                        $("#lsetup2").load("condtiongrid.jsp?docno="+refno+"&leaveid="+leaveid+"&disdata="+disdata);
                } else { 
                        $.messager.alert('Message', '  Not Deleted'); 
                }
            }
        }
        x.open("GET","deletedate.jsp?leaveid="+leaveid+"&refno="+refno,true);
        x.send();
    }
	   
    function funsave(){
        $.messager.confirm('Message', 'Do you want to save changes?', function(r){
            if(r==false) {
                return false; 
            } else{
                funsavedata();
            }
        });
    }
	     
    function funsavedata(){	 
        var z=0;
        var rows = $("#condtiongrid").jqxGrid('getrows');      
        var selectedrows=$("#condtiongrid").jqxGrid('selectedrowindexes');
            
        $('#algridlength').val(selectedrows.length);
        for (var i = 0; i < rows.length; i++) {
            for(var j=0;j<selectedrows.length;j++){
                if(selectedrows[j]==i){
                    newTextBox = $(document.createElement("input"))
                    .attr("type", "dil")
                    .attr("id", "condtest"+z)
                    .attr("name", "condtest"+z)
                    .attr("hidden", "true");  
                
                    newTextBox.val(rows[i].allowanceid+" :: ");
                    newTextBox.appendTo('form');
                    z++;
                }
            }
        }
        
        var rows = $("#leavesetupgrid").jqxGrid('getrows');      
        for(var i=0;i<rows.length;i++){
            if(parseInt(rows[i].checkclick)==1){
                newTextBox = $(document.createElement("input"))
                    .attr("type", "dil")
                    .attr("id", "leavetest"+0)
                    .attr("name", "leavetest"+0)
                    .attr("hidden", "true");  
                
                newTextBox.val(rows[i].ldocno+" :: "+rows[i].cf+" :: "+rows[i].deduct+" :: "+rows[i].l1+" :: "+rows[i].l2+" :: "+rows[i].l3+" :: "+rows[i].l1ded+" :: "+rows[i].l2ded+" :: "+rows[i].l3ded); 
                newTextBox.appendTo('form');
            }
        }

        document.getElementById("frmleavesetup").submit();
    } 
	     
    function funFocus(){}
	  
</script>  
 
</head>
<body onLoad="setValues();" >
<div id="mainBG" class="homeContent" data-type="background">
    <form id="frmleavesetup" action="saveLeavesetup" method="post" autocomplete="off"> 
        <jsp:include page="../../../../../header.jsp" />
        
        <div class='modern-ui hidden-scrollbar'>
            <div id="errormsg"></div>

            <div class="middle-panel">
                <span class="middle-panel-title">Leave Setup Details</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Ref No</label>
                    <div class="input-search-container" style="width: 125px;">
                        <input type="text" name="refno" id="refno" placeholder="Press F3" onKeyDown="gethrsetup(event);" value='<s:property value="refno"/>'>
                        <svg class="magnifier-icon" onclick="$('#refno').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    
                    <label class="lbl-right" style="width:80px; margin-left:15px;">Category</label>
                    <input type="text" name="category" id="category" style="width: 250px;" value='<s:property value="category"/>'>
                    
                    <div class="bounce" style="flex:1; text-align:center;">
                        <b><label id="showlabel" style="font-size: 13px;font-family: Tahoma; color:#6000FC" value='<s:property value="showlabel"/>'></label></b>
                    </div>
                </div>
            </div>

            <div style="display: flex; gap: 15px;">
                <div class="middle-panel" style="flex: 2; margin-bottom: 0;">
                    <span class="middle-panel-title">Leave Setup Setup</span>
                    <div id="lsetup1" class="grid-container" style="border: none;">
                        <jsp:include page="leavesetupgrid.jsp"></jsp:include>
                    </div>
                </div>

                <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
                    <span class="middle-panel-title">Condition Settings</span>
                    <div id="lsetup2" class="grid-container" style="border: none;">
                        <jsp:include page="condtiongrid.jsp"></jsp:include>
                    </div>
                    
                    <div class="field-row" style="justify-content: center; margin-top: 15px;">
                        <input type="button" id="savebtn" class="myButton" onclick="funsave();" value="Save"> 
                        <input type="button" id="deltbtn" onclick="fundel()" class="myButton-delete" style="margin-left:15px;" value="Delete">
                    </div>
                </div>
            </div>

            <!-- Hidden Logic Fields -->
            <div style="display:none;">
                <input type="hidden" id="docno" name="docno" value='<s:property value="docno"/>' />
                <input type="hidden" id="hidshowlabel" name="hidshowlabel" value='<s:property value="hidshowlabel"/>' />
                <input type="hidden" id="leaveid" name="leaveid" value='<s:property value="leaveid"/>' />
                <input type="hidden" id="newmode" name="newmode" value='<s:property value="newmode"/>' />
                <input type="hidden" id="algridlength" name="algridlength" value='<s:property value="algridlength"/>' />
                <input type="hidden" id="catid" name="catid" value='<s:property value="catid"/>' />
                <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
                <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/> 
                <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 
            </div>
            
        </div>
    </form>
</div>

<!-- Search Windows Outside of Form Content to prevent scrolling issues -->
<div id="refSearchwindow">
   <div></div><div></div>
</div>	 

</body>
</html>