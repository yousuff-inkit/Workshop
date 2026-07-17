<%@page import="com.dashboard.serviceandmaintenance.accidentsreported.ClsAccidentsReportedDAO" %>
<%ClsAccidentsReportedDAO car=new ClsAccidentsReportedDAO(); %>

 <%
           	String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
 %> 
          
<script>
$(document).ready(function () { 
	 var temp4='<%=branchval%>';
	 var dataacc;
	 if(temp4!='NA')
	 { 
	 	
		 dataacc='<%=car.getAccidentsReported(branchval)%>'; 
	 } 
	 else
	 { 
	 	
		 dataacc;
	 	
	 	}  
	


var num = 1; 
             // prepare the data
             var source =
             {
                 datatype: "json",
                 datafields: [
                           	{name : 'accdate' , type: 'date' },
      						{name : 'report', type: 'string'  },
      						{name : 'collectdate', type: 'date'    },
      						{name : 'place', type: 'String'    },
      						{name : 'accfines', type: 'number'    },
      						{name : 'claim', type: 'String'    },
      						{name : 'remarks', type: 'String'    },
      						{name : 'btnsave', type: 'String'  },
      						{name : 'btnclear',type:'String'},
      						{name : 'docno',type:'int'},
      						{name :'brhid',type:'string'},
      						{name :'reftype',type:'string'},
      						{name : 'reg_no',type:'string'},
      						{name : 'refname',type:'string'}
      						
      					
      						
      						],
                 /* url: url, */
                 localdata:dataacc,
                 
                 pager: function (pagenum, pagesize, oldpagenum) {
                     // callback called when a page or pagse size is changed.
                 }
             };
                          $("#accidentsRepGrid").on("bindingcomplete", function (event) {
             	$("#overlay, #PleaseWait").hide();
             	//$('#rentalInvoiceGrid').jqxGrid({ sortable: true});
             	});
             var dataAdapter = new $.jqx.dataAdapter(source,
             		 {
                 		loadError: function (xhr, status, error) {
 	                   // alert(error);    
 	                    }
 		            });
             var list = ['Own','Third Party'];
             $("#accidentsRepGrid").jqxGrid(
             {
                 width: '100%',
                 height: 500,
                 source: dataAdapter,
                 enableAnimations: true,
                 filtermode:'excel',
                 filterable: true,
                 sortable:true,
                 selectionmode: 'singlecell',
                // pagermode: 'default',
                editable:true,
                 //Add row method
                 handlekeyboardnavigation: function (event) {
                     var cell = $('#accidentsRepGrid').jqxGrid('getselectedcell');
                     if (cell != undefined && cell.datafield == 'docno' && cell.rowindex == num - 1) {
                         var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                         if (key == 13) {                                                        
                             var commit = $("#accidentsRepGrid").jqxGrid('addrow', null, {});
                             num++;                           
                         }
                     }
                 },
                
                 columns: [
 							{text: 'Reg No',datafield:'reg_no',width:'5%'},
                           	{text: 'Client',datafield:'refname',width:'15%'},
 							{ text: 'Accident Date', datafield: 'accdate',columntype:'datetimeinput',cellsformat:'dd.MM.yyyy',width:'7%'},
 							{ text: 'Police Report', datafield: 'report',width:'8%'},
 							{ text: 'Collection Date', datafield: 'collectdate',columntype:'datetimeinput',cellsformat:'dd.MM.yyyy',width:'7%'},
 							{ text: 'Place', datafield: 'place',width:'10%'},
 							{ text: 'Accident Fines', datafield: 'accfines',width:'7%',cellsformat:'d2'},
 							{ text: 'Claim', datafield: 'claim',columntype:'dropdownlist',width:'6%',
 								createeditor: function (row, column, editor) {
 		                            editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
 								}
 							},
 							{ text: 'Remarks', datafield: 'remarks',width:'30%'},
 							 { text: ' ', datafield: 'btnsave', width: '7%',columntype: 'button',editable:false, filterable: false,sortable:false
 							 },
 							{ text: 'Doc No',datafield: 'docno',width:'40%',hidden:true},
 							 { text: 'Branch',datafield: 'brhid',width:'40%',hidden:true},
 							{ text: ' ', datafield: 'btnclear', width: '7%',columntype: 'button',editable:false, filterable: false,sortable:false},
 							{ text: 'Ref Type', datafield: 'reftype', width: '10%',hidden:true}
 	              ]
             }); 
            
            /*  var rows=  $("#accidentsRepGrid").jqxGrid('getrows');
             var rowcount=rows.length;
             if(rowcount==0){
            	  $("#accidentsRepGrid").jqxGrid("addrow", null, {});
             } */
             

             $("#accidentsRepGrid").on('cellclick', function (event) 
               		{
           	   var datafield = event.args.datafield;

           	    var rowBoundIndex = event.args.rowindex;
           	
           	  
               		 
               		    var columnindex = event.args.columnindex;

             			  if(columnindex<6)
             				  {
             				
             				  if($('#accidentsRepGrid').jqxGrid('getcellvalue',rowBoundIndex, "btnsave")=="Edit"){
             					  
             					 $.messager.alert('Message',' Click Edit Button ','warning');   
            		        	 
             					  }
             				  
             				  
             				  }
             			  
             			
             		
                         if(datafield=="btnsave"){
                       	 if($('#accidentsRepGrid').jqxGrid('getcellvalue',rowBoundIndex, "btnsave")=="Save")
                       	 {
                       		 var accdate= $('#accidentsRepGrid').jqxGrid('getcellvalue',rowBoundIndex, "accdate");
                       		 var report= $('#accidentsRepGrid').jqxGrid('getcelltext', rowBoundIndex, "report");
                       		 var collectdate= $('#accidentsRepGrid').jqxGrid('getcellvalue',rowBoundIndex, "collectdate");
                       		 var place=$('#accidentsRepGrid').jqxGrid('getcellvalue',rowBoundIndex, "place");
                       		 var accfines=$('#accidentsRepGrid').jqxGrid('getcellvalue',rowBoundIndex, "accfines");
                       		 var claim=$('#accidentsRepGrid').jqxGrid('getcellvalue',rowBoundIndex, "claim");
                       		 var remarks=$('#accidentsRepGrid').jqxGrid('getcellvalue',rowBoundIndex, "remarks");
                       		 var docno=$('#accidentsRepGrid').jqxGrid('getcellvalue',rowBoundIndex, "docno");
                       		var  brhid=$('#accidentsRepGrid').jqxGrid('getcellvalue',rowBoundIndex, "brhid");
                       		var reftype=$('#accidentsRepGrid').jqxGrid('getcellvalue',rowBoundIndex, "reftype");
                		          $.messager.confirm('Message', 'Do you want to save changes?', function(r){
                		        	  
                		       
                		        	if(r==false)
                		        	  {
                		        		return false; 
                		        	  }
                		        	else{
                		        	 savegriddata(accdate,report,collectdate,place,accfines,claim,remarks,docno,brhid,reftype);
                		        	}
                			     });
                		 	  
                       	 }
                       	 else {
                       	
                       	  $('#accidentsRepGrid').jqxGrid('setcellvalue',rowBoundIndex, "btnsave","Save");
                       	 }
                         }
                         if(datafield=="btnclear"){
                        	 if($('#accidentsRepGrid').jqxGrid('getcellvalue',rowBoundIndex, "btnsave")=="Save")
                           	 {
                        		 $.messager.alert('Message',' Please Save','warning');   
                           	 }
                        	 else{
                        		 var docno=$('#accidentsRepGrid').jqxGrid('getcellvalue',rowBoundIndex, "docno");
                            		var  brhid=$('#accidentsRepGrid').jqxGrid('getcellvalue',rowBoundIndex, "brhid");
                        		 cleardata(docno,brhid);
                        	 }
                         }
               		   
               		}); 


          
});
function savegriddata(accdate,report,collectdate,place,accfines,claim,remarks,docno,brhid,reftype)
{

	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		
		
		 	var items= x.responseText;
		 	
		
		 	 $.messager.alert('Message', 'Record successfully Updated ', function(r){
				     
			     });
		 	funreload(event);
			
		 	 
    }
	}
     x.open("GET","savegrid.jsp?accdate="+accdate+"&report="+report+"&collectdate="+collectdate+"&place="+place+"&accfines="+accfines+"&claim="+claim.replace(/ /g, "%20")+"&remarks="+remarks.replace(/ /g, "%20")+"&docno="+docno+"&branchid="+brhid+"&reftype="+reftype,true);
    x.send();
   
  
} 
function cleardata(docno,brhid)
{

	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		
		
		 	var items= x.responseText;
		 	
		
		 	 $.messager.alert('Message', 'Record successfully Cleared ', function(r){
				     
			     });
		 	funreload(event);
			
		 	 
    }
	}
     x.open("GET","clearData.jsp?docno="+docno+"&branchid="+brhid,true);
    x.send();
   
  
} 
             //Accidents Reported grid end
             </script>
             <div id="accidentsRepGrid"></div>