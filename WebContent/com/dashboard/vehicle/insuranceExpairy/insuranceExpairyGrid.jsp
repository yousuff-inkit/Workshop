<%@ page import="com.dashboard.vehicle.ClsvehicleDAO" %>
<% ClsvehicleDAO cvd=new ClsvehicleDAO();%>
 
<% String contextPath=request.getContextPath();%>

 
 <%
           	String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
           String expdate = request.getParameter("exdate")==null?"0":request.getParameter("exdate").trim();
      
           	  %> 
           	  
           	  
           	  
   <!-- <style type="text/css">
        .redClass
        {
           font-size:15px; 
            background-color: #FFEBEB;
        }
        
        
   
        </style>     -->    	  
<script type="text/javascript">
 var temp4='<%=barchval%>';
var expdata;
if(temp4!='NA')
{ 
	
	 expdata='<%=cvd.insuexpirysearch(barchval,expdate)%>'; 
	//alert(ssss);
	
} 
else
{                       
	
	expdata;
	
	
	}  
 var list =['Comprehensive','3rd Party'];
$(document).ready(function () {
   
	
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                     {name : 'fleet_no', type: 'String'  },
						{name : 'flname', type: 'String'  },
						 {name : 'reg_no', type: 'String'  }, 
						 {name : 'reg_date', type: 'date'  }, 
						{name : 'ins_exp', type: 'date'  },
						 {name : 'ins_amt', type: 'number'  }, 
						
						{name : 'gname', type: 'String'  },
						{name : 'model', type: 'String'  },
						{name : 'color', type: 'String'  },
						
						{name : 'brand_name', type: 'String'},
		        		{name : 'rem', type: 'string'  },
						{name : 'pno', type: 'string'  },
						
						{name : 'ex_date', type: 'date'  },
						{name : 'btnsave', type: 'String'  },
						{name : 'itype', type: 'String'  },
						{name : 'inname', type: 'String'  },
						
						{name : 'docno', type: 'String'  },
						{name : 'brhid', type: 'String'  },
						{name : 'attachbtn', type: 'String'  },
				
						
					
						
					
						
						],
				    localdata: expdata,
        
        
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
    
    
   
   
    
    $("#insexpgrid").jqxGrid(
    {
        width: '100%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlecell',
        pagermode: 'default',
        editable:true,
        
        handlekeyboardnavigation: function (event) {
            
          	 var cell1 = $('#insexpgrid').jqxGrid('getselectedcell');
          	 
          	 
          	 if (cell1 != undefined && cell1.datafield == 'inname') {
          	 var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                   if (key == 114) {   
                	document.getElementById("rowindex").value = cell1.rowindex;
                  	inscompanySearchContent('insuCompanysearch.jsp');
                  
                   }
               }

        	       	
         
         }, 
        columns: [   
				     { text: 'Fleet NO', datafield: 'fleet_no', editable:false, width: '5%' },
				     { text: 'Reg.NO', datafield: 'reg_no', editable:false, width: '5%' }, 
				     { text: 'Fleet Name',datafield: 'flname',editable:false, width: '11%' },
					 { text: 'Tariff Group', datafield: 'gname', editable:false,width: '6%' },
					 { text: 'Brand',datafield: 'brand_name', editable:false,width: '8%',hidden:true },
					 { text: 'Model',datafield: 'model',editable:false, width: '8%',hidden:true },
					 { text: 'Reg_Date', datafield: 'reg_date',editable:false, width: '6%',cellsformat:'dd.MM.yyyy'},
					 { text: 'Ins Exp', datafield: 'ins_exp', width: '6%',editable:false,cellsformat:'dd.MM.yyyy'},
					 { text: 'Insurance Company', datafield: 'inname', width: '10%',editable:false	 },
					 			 
					 { text: 'Insurance Type',  datafield: 'itype',  width: '9%',columntype:'dropdownlist',createeditor: function (row, column, editor) {
	                       editor.jqxDropDownList({autoDropDownHeight: true,  enableBrowserBoundsDetection:true,source: list });
	                        
						
						},
						 cellbeginedit: function (row) {
								var temp=$('#insexpgrid').jqxGrid('getcellvalue', row, "btnsave");
								 if (temp =="Edit")
								       return false;
							     
						 }
					
	                  },
					 
					 
					 
					 
					 { text: 'Policy NO', datafield: 'pno', width: '8%',editable:true,
						 cellbeginedit: function (row) {
								var temp=$('#insexpgrid').jqxGrid('getcellvalue', row, "btnsave");
								 if (temp =="Edit")
								       return false;
							     
						 }
					 
					 },
					 { text: 'Extended Date', datafield: 'ex_date', width: '8%',editable:true,columntype: 'datetimeinput',cellsformat:'dd.MM.yyyy',
						 cellbeginedit: function (row) {
								var temp=$('#insexpgrid').jqxGrid('getcellvalue', row, "btnsave");
								 if (temp =="Edit")
								       return false;
							     
						 }
					 },
					 { text: 'Remarks', datafield: 'rem', width: '14%',editable:true,
						 cellbeginedit: function (row) {
								var temp=$('#insexpgrid').jqxGrid('getcellvalue', row, "btnsave");
								 if (temp =="Edit")
								       return false;
							     
						 }},
				    { text: ' ', datafield: 'attachbtn', width: '6%',columntype: 'button',editable:false, filterable: false},
					 { text: ' ', datafield: 'btnsave', width: '6%',columntype: 'button',editable:false, filterable: false},
					 { text: 'invcomdoc', datafield: 'invcomdoc', width: '6%',hidden:true},
					 { text: 'docno', datafield: 'docno', width: '6%',hidden:true},
					 { text: 'brhid', datafield: 'brhid', width: '6%',hidden:true}
					
						
					 
					]
   
    });
    
    
  
    
    
     $("#insexpgrid").on('cellclick', function (event) 
    		{
    		 
    		    var datafield = event.args.datafield;

    		    var rowBoundIndex = event.args.rowindex;
    		    var columnindex = event.args.columnindex;
    			  
    		 
    			  if(columnindex>7)
    				  {
    				  if(columnindex!=13 && columnindex!=14 )
    					  {
    				  if($('#insexpgrid').jqxGrid('getcellvalue',rowBoundIndex, "btnsave")=="Edit"){
    					  $.messager.alert('Message','Click Edit Button','warning');
    					
    				            }
    				  
    					  }
    				  
    				  
    				  }
    		    
    				 if(datafield=="attachbtn"){
    		            	
                		 
                		 document.getElementById("docnosss").value=$('#insexpgrid').jqxGrid('getcellvalue',rowBoundIndex, "docno");
                		 
                		 document.getElementById("brhs").value=$('#insexpgrid').jqxGrid('getcellvalue',rowBoundIndex, "brhid");
                		
                		 funAttachBtn();
                		 
                		 
      			 }
      			  
              if(datafield=="btnsave"){
            	 if($('#insexpgrid').jqxGrid('getcellvalue',rowBoundIndex, "btnsave")=="Save"){
            		
            		 var invexpdate= $('#insexpgrid').jqxGrid('getcelltext', rowBoundIndex, "ins_exp");
            		 var fleetno= $('#insexpgrid').jqxGrid('getcellvalue',rowBoundIndex, "fleet_no");
            		 var pnoval= $('#insexpgrid').jqxGrid('getcellvalue',rowBoundIndex, "pno");
            		 var exdate= $('#insexpgrid').jqxGrid('getcelltext', rowBoundIndex, "ex_date");
            		 var invtype= $('#insexpgrid').jqxGrid('getcellvalue', rowBoundIndex, "itype");
            		 var comdoc= $('#insexpgrid').jqxGrid('getcellvalue', rowBoundIndex, "invcomdoc");
            		 var renval1=$('#insexpgrid').jqxGrid('getcellvalue',rowBoundIndex, "rem");
            		 
            		 var docno=$('#insexpgrid').jqxGrid('getcellvalue',rowBoundIndex, "docno");
            		 var branchid=$('#insexpgrid').jqxGrid('getcellvalue',rowBoundIndex, "brhid");
            		 
            		 //for 
            		 
            		 
            		 var renval;
		            		 if(comdoc==""||typeof(comdoc)=="undefined")
		            		 {
		            			
		            			  $.messager.alert('Message','Select Insurance Company','warning');
		                       
		            			  
		            				return false; 
		            			
					            		 }
			            		 if(invtype==""||typeof(invtype)=="undefined")
			            		 {
			            			
			            			 $.messager.alert('Message','Select Insurance Type','warning');
			                       
			            			  
			            				return false; 
			            			
			            		 }
            	 	 
            		          if(pnoval==""||typeof(pnoval)=="undefined")
				            		 {
            		        	  $.messager.alert('Message','Enter Policy NO','warning'); 
				            			
				            			  
				            				return false; 
				            		 }
				            		
            		 
				            		 if(renval1==""||typeof(renval1)=="undefined")
				            		 {
				            			  $.messager.alert('Message',' Enter Remarks','warning'); 
				                         
				            				return false; 
				            			renval="";
				            		 }  
				            		 else{
				            			 renval=$('#insexpgrid').jqxGrid('getcellvalue',rowBoundIndex, "rem");
				            		    }
				            		 
            		
					            		 if(exdate==null||typeof(exdate)=="undefined")
					            		 {
					            			
					            			 $.messager.alert('Message',' Enter Extended Date','warning'); 
					                       
					            			  
					            				return false; 
					            			
					            		 }
            		 
            		 
				            		 var nmax = renval.length;
				            		
				            		
				     		           if(nmax>39)
				     		        	   {
				     		        	   
				     		        	  $.messager.alert('Message','Remarks cannot contain more than 40 characters ','warning');   
				     		        	 
				             			  
				             				return false; 
				     		        	   
				     		        	 
				     		        	 
				     		        	   } 
     		                          $.messager.confirm('Message', 'Do you want to save changes?', function(r){
     		        	  
     	     		       
					       		        	if(r==false)
					       		        	  {
					       		        		return false; 
					       		        	  }
					       		        	else{
					        				 savegriddata(pnoval,exdate,renval,fleetno,invexpdate,invtype,comdoc,docno,branchid);
					       		        	   }
     		                      });
            	 }
            	 else {
            		 
            	
            	  $('#insexpgrid').jqxGrid('setcellvalue',rowBoundIndex, "btnsave","Save");
            	    }
              }
    		   
    		}); 

   
     $('#insexpgrid').on('celldoubleclick', function (event) {
     	
    	 var dataField = event.args.datafield;
    	 
    	 
    	 
     	
       	  if(dataField == "inname")
       		  { 
       		
       		 var rowindextemp = event.args.rowindex;
       	    document.getElementById("rowindex").value = rowindextemp;  
       	   
       	 inscompanySearchContent('insuCompanysearch.jsp');
     
       		  } 
       	  
       	
  	  
       	  
           }); 
    
});
function funAttachBtn(){
	
	  $("#windowattach").jqxWindow('setTitle',"VEH - "+document.getElementById("docnosss").value);
	changeAttachContent("<%=contextPath%>/com/dashboard/Attach.jsp?formCode=VEH&docno="+document.getElementById("docnosss").value+"&barchvals="+document.getElementById("brhs").value);		

}

function savegriddata(pnoval,exdate,renval,fleetno,invexpdate,invtype,comdoc,docno,branchid)
{

	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		
		
		 	var items= x.responseText;
		 	
		 	 $.messager.alert('Message', '  Record successfully Updated ', function(r){
		 		 
		 		 
				     
			     });
		 	 
		 	funreload(event);
		 	 
    }
	}
     x.open("GET","insusaveGriddate.jsp?pnoval="+pnoval+"&exdate="+exdate+"&remarks="+renval+"&fleetno="+fleetno+"&invexpdate="+invexpdate+"&invtype="+invtype+"&comdoc="+comdoc+"&docno="+docno+"&branchid="+branchid,true);
    x.send();
   
  
}
</script>
<div id="insexpgrid"></div>
<input type="hidden" id="docnosss">
<input type="hidden" id="brhs">
  <input type="hidden" id="rowindex"/> 