<%@page import="com.common.ClsAttach" %>
<%ClsAttach ca=new ClsAttach(); %>

<%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/resample.js"></script>
 <% String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno"); %>
 
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

/* File Input Override */
.modern-ui input[type="file"] {
    font-size: 11px;
    padding: 0;
    border: none;
    background: transparent;
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

.modern-ui .myButton-success {
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
    background: linear-gradient(135deg, #16a34a 0%, #15803d 100%);
    color: #ffffff;
    white-space: nowrap;
}
.modern-ui .myButton-success:hover { background: linear-gradient(135deg, #15803d 0%, #166534 100%); }

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
</style>

	<script type="text/javascript">
	$(document).ready(function(){
		
		getRefType();
		var data4='<%= ca.reGridload(docNo,request.getParameter("formCode")) %>';
		
		Check(data4);
			});	
	
	function Check(data4){
		   
		
		  var source =
          {
              datatype: "json",
              datafields: [
						{name : 'sr_no', type: 'string'  },
   						{name : 'extension', type: 'string'  },
   						{name : 'description', type: 'string'    },
   						{name : 'type', type: 'string'    },
   						{name : 'filename', type: 'string'    },
   					    {name : 'path', type: 'string'    }
   						     						
               ],
               localdata: data4, 
              pager: function (pagenum, pagesize, oldpagenum) {
                  // callback called when a page or page size is changed.
              }
          };
          
          var dataAdapter = new $.jqx.dataAdapter(source,
          		 {
              		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
          
          $("#jqxDocumentsAttach").jqxGrid(
          {
              width: '100%',
              height: 300,
              source: dataAdapter,
              editable: true,
              theme: 'energyblue',
              selectionmode: 'singlerow',
              columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              datafield: 'sr_no', width: '10%',cellsalign: 'center', align: 'center', editable: false	},
							{ text: 'Doc Type', datafield: 'extension', width: '10%', editable: false },
							{ text: 'Description', datafield: 'description', width: '35%', editable: false },
							{ text: 'Type', datafield: 'type', width: '25%', editable: false },
							{ text: 'File Name', datafield: 'filename', width: '20%', editable: false },
							{ text: 'File Location', datafield: 'path', width: '20%', editable: false,hidden:true }
	              ]
          });	
		 $('#jqxDocumentsAttach').on('rowdoubleclick', function (event) 
              { 
               var rowindexes=event.args.rowindex;
               SaveToDisk($('#jqxDocumentsAttach').jqxGrid('getcellvalue', rowindexes, "path"),$('#jqxDocumentsAttach').jqxGrid('getcellvalue', rowindexes, "filename"));
              }); 
		 
		 $('#jqxDocumentsAttach').on('rowclick', function (event) 
	              { 
	               var rowindexes=event.args.rowindex;
	               document.getElementById("filename").value= $('#jqxDocumentsAttach').jqxGrid('getcellvalue', rowindexes, "filename");
	              }); 
	}
	 function ajaxFileUpload()  
	      {  
		   var reftypid=document.getElementById("reftypid").value;
			    //check whether browser fully supports all File API
			    if (window.File && window.FileReader && window.FileList && window.Blob)
			    {
			        //get the file size and file type from file input field
			        var fsize = $('#file')[0].files[0].size;
			        
			        if(fsize>1048576) //do something if file size more than 1 mb (1048576)
			        {
			            //$.messager.alert('Message',fsize +' bites\nToo big!','warning');
			            $.messager.show({title:'Message',msg: fsize +' bytes too big ! Maximum Size 1 MB.',showType:'show',
                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                        }); 
			            return;
			        }
			    }else{
			    	//$.messager.alert('Message','Please upgrade your browser, because your current browser lacks some new features we need!','warning');
			    	 $.messager.show({title:'Message',msg:'Please upgrade your browser, because your current browser lacks some new features we need!',showType:'show',
	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	                        }); 
			        return;
			    }
			
	          $.ajaxFileUpload  
	          (  
	              {  
	                  url:'fileAttachAction.action?formCode=<%=request.getParameter("formCode")%>&doc_no=<%=request.getParameter("docno")%>&descpt='+$("#txtdesc").val()+'&reftypid='+$("#reftypid").val() ,
	                  secureuri:false,//false  
	                  fileElementId:'file',//id  <input type="file" id="file" name="file" />  
	                  dataType: 'json',// json  
	                  success: function (data, status)  //  
	                  {  
	                      //alert(data.message);//jsonmessage,messagestruts2
	                 	
	               //       $('#refreshdiv').load();
	                      <%-- var data='<%= com.common.ClsAttach.reload(docNo) %>';
	                      alert("============="+data); --%>
	                     if(status=='success'){
	                         funAttachBtn();
	                         $.messager.show({title:'Message',msg:'Successfully Uploaded',showType:'show',
	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	                        }); 
	                      }
	                     
	                      $("#testImg").attr("src",data.message);
	                      if(typeof(data.error) != 'undefined')  
	                      {  
	                          if(data.error != '')  
	                          {  
	                              //$.messager.alert('Message',data.error);
	                              $.messager.show({title:'Message',msg: data.error,showType:'show',
	  	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	  	                        }); 
	                          }else  
	                          {  
	                              //$.messager.alert('Message',data.message);
	                              $.messager.show({title:'Message',msg: data.message,showType:'show',
		  	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
		  	                        }); 
	                          }  
	                      }  
	                  },  
	                  error: function (data, status, e)//  
	                  {  
	                      //alert(e);  
	                      $.messager.alert('Message',e);
	                  }  
	              }  
	          )  
	          return false;  
	      }
	
	 function reload(){
		$("#jqxDocumentsAttach").jqxGrid('updatebounddata', 'sort');
		
		<%--  $('#jqxDocumentsAttach').jqxGrid('refreshdata');
		 //Thread.sleep(10000);
		 $("#jqxDocumentsAttach").jqxGrid('addrow', null, <%= com.common.ClsAttach.reload(docNo)%>);
		 $("#jqxDocumentsAttach").jqxGrid('addrow', null, <%= com.common.ClsAttach.reload(docNo)%>); --%>
	 }
 
	function SaveToDisk(fileURL, fileName) {
	  //alert(fileURL);
	   //fileName='';
	   var host = window.location.origin;
	   //alert("hooosssst"+host);
	  
	   var splt = fileURL.split("webapps"); 
	  //alert("after split"+splt[1]);
	   var repl = splt[1].replace( /;/g, "/");
	   //alert("repl"+repl);
	   //alert("after replace===="+repl);
	   fileURL=host+repl;
	   //alert("fileURL===="+fileURL);
	    // for non-IE
	    if (!window.ActiveXObject) {
	        var save = document.createElement('a');
	        //alert(save);
	       // alert(fileURL);
	        save.href = fileURL;
	        save.target = '_blank';
	        save.download = fileName || 'unknown';
			
	        window.open(save.href,"mywindow","menubar=1,resizable=1,width=500,height=500");
	        
	        //var event = document.createEvent('Event');
	       // alert(event);
	        //event.initEvent('click', true, true);
	        //save.dispatchEvent(event);
	        //(window.URL || window.webkitURL).revokeObjectURL(save.href);
	    }

	    // for IE
	    else if ( !! window.ActiveXObject && document.execCommand)     {
	        var _window = window.open(fileURL, '_blank');
	        _window.document.close();
	        _window.document.execCommand('SaveAs', true, fileName || fileURL)
	        _window.close();
	    }
	}
	
	function Delete(){
	    var filename=document.getElementById("filename").value;
	    /* var spltname = filename.split(".");
	    alert("==spltname==="+spltname[0]); */
	    <%-- alert("==filename=="+filename);
	    var dtype=<%=request.getParameter("formCode")%>;
	    alert("==dtype=="+dtype);
	    var doc_no=<%=request.getParameter("docno")%>;
	     --%>
	   
	    //alert("==doc_no=="+doc_no);
	 var x=new XMLHttpRequest();
	 var items,brchItems,currItems,mcloseItems;
	 x.onreadystatechange=function(){
	  if (x.readyState==4 && x.status==200)
	   {
	         items= x.responseText;
	         if(items>0){
	        	 funAttachBtn();
	        	 //$.messager.alert('Message','Successfully Deleted');
	        	 $.messager.show({title:'Message',msg:'Successfully Deleted',showType:'show',
                     style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                 }); 
	         }
	         else{
	  		  //$.messager.alert('Message','Not Deleted');
	  		 $.messager.show({title:'Message',msg:'Not Deleted',showType:'show',
                 style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
             }); 
	  	     }
	      }
	  else
	   {}
	 }
	 x.open("GET",<%=contextPath+"/"%>+"fileAttachDelete.jsp?filename="+filename,true);
	 x.send();
	}
	
	 function saveViaAJAX()
	 {
		 
		
		 var testCanvas =null;
		 var formname=document.getElementById("formdetailcode").value;
		 var docno=document.getElementById("docno").value;
		 var reftypid=document.getElementById("reftypid").value;
		 if(docno==""){
			 document.getElementById("errormsg").innerText="Please Select a Document Number";
	  		 return false;
		 }
		 var iscapture=document.getElementById("iscapture").value;
			
			if(iscapture==1){
				 testCanvas = document.getElementById("canvasids"); 
			}
			else{
				testCanvas = document.getElementById("canvasid");  
				
			}
			
		  
		 	var canvasData = testCanvas.toDataURL("image/png");
		 	
		 	var postData = "canvasData="+canvasData;
	 	//var canvasData = testCanvas.toDataURL("image/png");
	 	
	 	
	 	var ajax = new XMLHttpRequest();
	 	ajax.open("POST",<%=contextPath+"/"%>+'saveImages.jsp?formname='+formname+'&docno='+docno+'&descpt='+$("#txtdesc").val()+'&reftypid='+$("#reftypid").val(),true);    
	 	ajax.setRequestHeader('Content-Type', 'canvas/upload');
	 	
	 	ajax.onreadystatechange=function()
	   	{
	 		if (ajax.readyState == 4)
	 		{ 
	 			//document.getElementById("savemsg").innerText="Successfully Attached";
	 			funAttachBtn();
	 			 $.messager.show({title:'Message',msg:'Successfully Attached',showType:'show',
                     style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                 });
	    		  //$.messager.alert('Message',"Successfully Attached");
	    		 
	 			//alert(ajax.responseText);
	 			// Write out the filename.
	     		
	 		}
	   	}

	 	ajax.send(postData);  
	 }

function upload(){
	var iscapture=document.getElementById("iscapture").value;
	
	if(iscapture==1){
		saveViaAJAX();
	}
	else{
		
		 var path=document.getElementById("file").value;
		 var fsize = $('#file')[0].files[0].size;
		 //alert(fsize);
		 var extn = path.substring(path.lastIndexOf(".") + 1, path.length);
		 //alert(extn);
		 if((extn=='jpg')||(extn=='png')||(extn=='jpeg')||(extn=='gif')||(extn=='bmp')||(extn=='JPG')||(extn=='PNG')||(extn=='JPEG')||(extn=='GIF')||(extn=='BMP'))
	        {
			 
			 if(fsize>1048576)
				 { 
				 saveViaAJAX();
				 }
			 else{
		        	ajaxFileUpload();	
		        }
			 
			 
	        }
	        else{
	        	ajaxFileUpload();	
	        }
	}
		 
	 }
	 
	 
	 
function loading(){
	document.getElementById("iscapture").value=0;
	var path=document.getElementById("file").value;
	 var fsize = $('#file')[0].files[0].size;
	 //alert(fsize);
	 var extn = path.substring(path.lastIndexOf(".") + 1, path.length);
	
	 if((extn=='jpg')||(extn=='png')||(extn=='jpeg')||(extn=='gif')||(extn=='bmp')||(extn=='JPG')||(extn=='PNG')||(extn=='JPEG')||(extn=='GIF')||(extn=='BMP'))
       {
		 
		 if(fsize>1048576)
			 {
			 document.getElementById("errormsg").innerText="Please Wait......";
			 }
		 
		 
		 
       }
      
	
	
}

function comonsnapshotWindow()
{

	 document.getElementById("iscapture").value=1;
	 
    window.open(<%=contextPath+"/"%>+"com/common/snapshot.jsp", "CommonCamera",'menubar=0,resizable=1,width=400,height=440, top=50, left=380');
     
    
}


function getRefType()
{	
	
	var dtype=document.getElementById("formdetailcode").value;
	
var x=new XMLHttpRequest();
var items,refname,refcode,refdocno;
x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{  
        items= x.responseText;
        items=items.split('####');

        
        
        refname=items[0].split(",");
        refcode=items[1].split(",");
        refdocno=items[2].split(",");
        	var optionref = '';
        	var optionscurr = '';
       for ( var i = 0; i < refname.length; i++) {
    	   
    	   
    	   getRef(refname[0]);
    	   optionref += '<option value="' + refname[i] + '">' + refname[i] + '</option>';
    	  
        }
       $("select#reftype").html(optionref); 
       
        	
        }
	else
		{
		}
}
x.open("GET",<%=contextPath+"/"%>+"com/common/getRefType.jsp?dtype="+dtype,true);
x.send();
}


function getRef(c){

	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		 	var items= x.responseText;
		 	items = items.split('####');
		 	
		 		var reftype = items[0].split(",");
		 		var refcode  = items[1].split(",");
		 		var refdocno  = items[2].split(",");
		 		document.getElementById("reftypid").value=refdocno;
		    }
	       else
		  {}
     }
      x.open("GET", <%=contextPath+"/"%>+"com/common/getRef.jsp?reftype="+c,true);
     x.send();
    
   }

	 
	</script>
</head>	
<body>
<div id="mainBG" class="homeContent" data-type="background">
    <div class="modern-ui hidden-scrollbar">
        <div id="errormsg"></div>
        
        <div class="middle-panel">
            <span class="middle-panel-title">Attachment Details</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Description</label>
                <input type="text" name="txtdesc" id="txtdesc" style="flex:2;" value='<s:property value="txtdesc"/>'>
                
                <label class="lbl-right" style="width:100px; margin-left:20px;">Ref Type</label>
                <select name="reftype" id="reftype" style="flex:1;" onchange="getRef(this.value);"></select>
            </div>
            
            <div class="field-row" style="margin-top: 15px;">
                <label class="lbl-right" style="width:100px;">File Upload</label>
                <div style="flex: 1; border: 1px dashed #b8c6d8; padding: 6px 12px; border-radius: 4px; background: #f8fafc; display: flex; align-items: center; max-width: 400px;">
                    <input type="file" id="file" name="file" onChange="return loading();" style="width:100%; cursor: pointer;" />
                </div>
            </div>
            
            <div class="field-row" style="justify-content: flex-end; margin-top: 20px; padding-top: 15px; border-top: 1px solid #e2e8f0; margin-bottom: 0;">
                <button class="myButton-success" id="btnsearch" name="btnsearch" title="Attach" onclick="return upload();">
                    <img alt="Attach" src="<%=contextPath%>/icons/attachicon.png" style="width:14px; height:14px; vertical-align:middle; margin-right:4px;"> Attach
                </button>
                <button class="myButton-delete" id="btnAttachDelete" title="Delete current Document" onclick="Delete();" style="margin-left: 10px;">
                    <img alt="deleteDocument" src="<%=contextPath%>/icons/attachdelete.png" style="width:14px; height:14px; vertical-align:middle; margin-right:4px;"> Delete
                </button>
                <button class="myButton" id="click" title="Take SnapShot" onclick="comonsnapshotWindow();" style="margin-left: 10px;">
                    <img alt="Snapshot" src="<%=contextPath%>/icons/asnapshot.png" style="width:14px; height:14px; vertical-align:middle; margin-right:4px;"> SnapShot
                </button>
            </div>
        </div>

        <div class="middle-panel">
            <span class="middle-panel-title">Attached Documents</span>
            <div id="refreshdiv" class="grid-container" style="border: none;">
                <div id="jqxDocumentsAttach"></div>
            </div>
        </div>

        <!-- Hidden Logic Fields -->
        <div style="display:none;">
            <input type="hidden" name="filename" id="filename" value='<s:property value="filename"/>'/>
            <input id="reftypid" type="hidden"  />									
            <input id="width" type="hidden" value="640" />
            <input id="height" type="hidden" />
            <input id="data" type="hidden" />
            <input id="iscapture" type="hidden" />
            <span id="message"></span>
            <canvas id="canvasid" height="480" width="640"></canvas>
            <canvas id="canvasids" height="240" width="320"></canvas>
            <div id="img"></div>
        </div>
        
    </div>
</div>
</body>
 <script>
	(function ( $width, $height, $file) {
		
		// (C) WebReflection Mit Style License
		
		// simple FileReader detection
		
		
		// async callback, received the
		// base 64 encoded resampled image
		function resampled(data) {
			//$message.innerHTML = "done";
			
		/* 	  ($img.lastChild || $img.appendChild(new Image)
			).src = data; */
			document.getElementById("data").value=data;
			/* var img = document.getElementById('imgid').src;

			alert(img.getAttribute('src')); // foo.jpg
			alert(img.src); */
			
			/* document.getElementById('imgid').src=data; */
			
			var imgid = new Image();
			imgid.src =data;
			
			var temp_paint = $('#canvasid');
			var temp_ctx = temp_paint[0].getContext('2d');
			
			  //var img = document.getElementById('imgid').src;
			//alert(img);
			 document.getElementById("errormsg").innerText=" ";
			  temp_ctx.drawImage(imgid, 0, 0,640, 480);
	     
		}
		
		// async callback, fired when the image
		// file has been loaded
		function load(e) {
			//$message.innerHTML = "resampling ...";
			// see resample.js
			Resample(
					this.result,
					this._width || null,
					this._height || null,
					resampled
			);
			
		}
		
		// async callback, fired if the operation
		// is aborted ( for whatever reason )
		function abort(e) {
			//$message.innerHTML = "operation aborted";
		}
		
		// async callback, fired
		// if an error occur (i.e. security)
		function error(e) {
			//$message.innerHTML = "Error: " + (this.result || e);
		}
		
		// listener for the input@file onchange
		$file.addEventListener("change", function change() {
			var
				// retrieve the width in pixel
				width = parseInt($width.value, 10),
				// retrieve the height in pixels
				height = parseInt($height.value, 10),
				// temporary variable, different purposes
				file
			;
			// no width and height specified
			// or both are NaN
			if (!width && height) {
				// reset the input simply swapping it
				$file.parentNode.replaceChild(
					file = $file.cloneNode(false),
					$file
				);
				// remove the listener to avoid leaks, if any
				$file.removeEventListener("change", change, false);
				// reassign the $file DOM pointer
				// with the new input text and
				// add the change listener
				($file = file).addEventListener("change", change, false);
				// notify user there was something wrong
				//$message.innerHTML = "please specify width or height";
			} else if(
				// there is a files property
				// and this has a length greater than 0
				($file.files || []).length &&
				// the first file in this list 
				// has an image type, hopefully
				// compatible with canvas and drawImage
				// not strictly filtered in this example
				/^image\//.test((file = $file.files[0]).type)
			) {
				// reading action notification
				//$message.innerHTML = "reading ...";
				// create a new object
				file = new FileReader;
				// assign directly events
				// as example, Chrome does not
				// inherit EventTarget yet
				// so addEventListener won't
				// work as expected
				file.onload = load;
				file.onabort = abort;
				file.onerror = error;
				// cheap and easy place to store
				// desired width and/or height
				file._width = width;
				file._height = height;
				// time to read as base 64 encoded
				// data te selected image
				file.readAsDataURL($file.files[0]);
				// it will notify onload when finished
				// An onprogress listener could be added
				// as well, not in this demo tho (I am lazy)
			} else if (file) {
				// if file variable has been created
				// during precedent checks, there is a file
				// but the type is not the expected one
				// wrong file type notification
				//$message.innerHTML = "please chose an image";
			} else {
				// no file selected ... or no files at all
				// there is really nothing to do here ...
				//$message.innerHTML = "nothing to do";
			}
		}, false);
	}(
	
		// all required fields ...
		document.getElementById("width"),
		document.getElementById("height"),
		document.getElementById("file")
	));
	</script>
</html>