<%@page import="com.dashboard.serviceandmaintenance.ClsServiceAndMaintenanceDAO"%>
<%ClsServiceAndMaintenanceDAO csm=new ClsServiceAndMaintenanceDAO(); %>

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

<%String docno=request.getParameter("docno")==null?"0":request.getParameter("docno"); %>
<%String fleetno=request.getParameter("fleetno")==null?"0":request.getParameter("fleetno"); %>

<script type="text/javascript">
      var ddd='<%=csm.getNewDamage(fleetno,docno)%>';
        $(document).ready(function () { 	
        	
        	var num = 0;
        	var source =
            {
                datatype: "json",
                datafields: [

{name : 'code' , type: 'string' },
	{name : 'description' , type:'string'},
	{name : 'type' , type:'String'},
	{name : 'remarks' , type:'string'},
	 {name : 'upload',type:'string'},
	 {name :'dmgid',type:'string'},
	 {name :'srno',type:'string'},
	 {name :'path',type:'String'},
	 {name :'btnpreview',type:'String'},
	 {name :'btnattachs',type:'String'},
	 
	 
	],
                
                localdata: ddd,
                //url: url,
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            var list = ['Scratch', 'Dent', 'Crack','Lost'];
           
            $("#newGrid").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                columnsresize: true,
                pageable: false,
                altRows: true,
                sortable: false,
                selectionmode: 'singlecell',
                editable:true,
                
       
                columns: [
{ text: 'Code', datafield: 'code', width: '8%',editable:false},
{ text: 'Description',  datafield: 'description',  width: '30%',editable:false},
{ text: 'Type',  datafield: 'type',  width: '8%'  ,editable:false,columntype:'dropdownlist',
	createeditor: function (row, column, editor) {
        editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
		} },
{ text: 'Remarks', datafield:'remarks', width:'20%',editable:false },
{ text:'Damage Id',datafield:'dmgid',width:'20%',hidden:true},
{ text:'Srno',datafield:'srno',width:'20%',hidden:true},
{   text: 'Choose  File', width:'20%', columntype: 'custom',datafield:'upload',
 
    createeditor: function (row, cellvalue, editor, cellText, width, height) {
      
         editor.html('<input type="file" id="file" name="file"  />' ); 
    },
    geteditorvalue: function (row, cellvalue, editor) {
        // return the editor's value.
        var value = $("#file").val();
        return value.substring(value.lastIndexOf("\\") + 1, value.length);
    }},
   /*  { text:'Attach',datafield:'attach',width:'10%',columntype:'custom',
        createeditor: function (row, cellvalue, editor, cellText, width, height) {
            var srNo = $('#newGrid').jqxGrid('getcellvalue', row, 'srno');
             editor.html('<input type="button" class="myButton" onClick="return ajaxFileUpload('+srNo+');"  width="5" value="Attach"/>'); 
        }}, */
        { text: ' ', datafield: 'btnattachs', width: '7%',columntype: 'button',editable:false, filterable: false,sortable:false},
    { text: ' ', datafield: 'btnpreview', width: '7%',columntype: 'button',editable:false, filterable: false,sortable:false},
	              ], 

            }); 
            

        });
        $('#newGrid').on('cellclick', function (event) 
                { 
                 var rowindexes=event.args.rowindex;
                 var columnindex = event.args.columnindex;



						if(columnindex==7)
						 {
							 var srNo = $('#newGrid').jqxGrid('getcellvalue', rowindexes, 'srno');
							 
							 
							 
							 ajaxFileUpload(srNo);
							 
						//SaveToDisk($('#newGrid').jqxGrid('getcellvalue', rowindexes, "path"),$('#newGrid').jqxGrid('getcellvalue', rowindexes, "upload")); 
						
						 }


     			  if(columnindex==8)
     				  {
     				  
     				 SaveToDisk($('#newGrid').jqxGrid('getcellvalue', rowindexes, "path"),$('#newGrid').jqxGrid('getcellvalue', rowindexes, "upload")); 
     				
     				  }
                 
                 
                });  
        
        
        
  		/*  $('#newGrid').on('rowclick', function (event) 
  	               { 
  	                var rowindexes=event.args.rowindex;
  	             
  	               });  */
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
    		      //  alert(fileURL);
    		        save.href = fileURL;
    		        save.target = '_blank';
    		        save.download = fileName || 'unknown';
    				
    		        window.open(save.href,"mywindow","menubar=1,resizable=1,width=500,height=500");
    		        
    		   
    		    }

    		    // for IE
    		    else if ( !! window.ActiveXObject && document.execCommand)     {
    		        var _window = window.open(fileURL, '_blank');
    		        _window.document.close();
    		        _window.document.execCommand('SaveAs', true, fileName || fileURL)
    		        _window.close();
    		    }
    		}


  	         function ajaxFileUpload(row)  
  	         {  
  	        
                   var aa=$('input[type=file]').val();
  	     
  	       	 if($('input[type=file]').val()=="" || typeof(aa)=="undefined"){
  	       		
  	       		  $.messager.show({title:'Message',msg:'Please Choose A File',showType:'show',
	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	                        }); 
  	       		 return false;
  	       	 }
  	      
  	             $.ajaxFileUpload  
  	             (  
  	                 {  
  	                   /* url:'fileUploadInsp.action?formdetailcode='+document.getElementById("formdetailcode").value+'&doc='+document.getElementById("docno").value+'&srno=+row',//   */
  	                   
  	                   url:'fileUploadInsp.action?formdetailcode=VIP&doc=<%=request.getParameter("docno")%>+&srno='+row, 
  	                   
  
  	                     secureuri:false,//false  
  	                     fileElementId:'file',//id  <input type="file" id="file" name="file" />  
  	                     dataType: 'json',// json  
  	                     success: function (data, status)  //  
  	                     {  
  	                   	  //alert(data.message);
  	                   	  //alert(status);
  	                   	  if(status=="success"){
  	                   		
  	                   		funattachss(); 
	                      
	                      $.messager.show({title:'Message',msg:'Successfully Uploaded',showType:'show',
	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	                        }); 
  	                   		
  	                   		  
  	                   	  }
  	                       
  	                         if(typeof(data.error) != 'undefined')  
  	                         {  
  	                             if(data.error != '')  
  	                             {  
  	                            //     alert(data.error);  
  	                             }else  
  	                             {  
  	                          //       alert(data.message);  
  	                             }  
  	                         }  
  	                     },  
  	                     error: function (data, status, e)//  
  	                     {  
  	                        // alert(e);  
  	                     }  
  	                 }  
  	             )  
  	             return false;  
  	         }
  	               


            </script>
            <div id="newGrid"></div>


</body>
</html>