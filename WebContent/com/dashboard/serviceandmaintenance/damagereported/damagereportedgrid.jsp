<%@page import="com.dashboard.serviceandmaintenance.ClsServiceAndMaintenanceDAO" %>

 <%
           	String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
ClsServiceAndMaintenanceDAO dao= new ClsServiceAndMaintenanceDAO();
 %> 
           	  

   
<script type="text/javascript">
 var temp4='<%=barchval%>';
var damagedata;

 if(temp4!='NA')
{ 
	
	 damagedata='<%=dao.damageReportSearch(barchval)%>'; 
	
} 
else
{ 
	
	damagedata;
	
	}  


 var list =['Chargeable','Way Off'];
$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                     
                     

                       {name : 'refvoucherno', type: 'String'  },
                        {name : 'doc_no', type: 'String'  },
						
						{name : 'date', type: 'date'  },
					
						{name : 'type', type: 'String'  },
						{name : 'reftype', type: 'String'  },
						{name : 'refdocno', type: 'String'  },
						
						{name : 'rfleet', type: 'String'},
		        	
						{name : 'btnsave', type: 'String'  },
					
						{name : 'amount', type: 'number'  },
						{name : 'reason', type: 'String'  },
						
						{name : 'brhid', type: 'String'  },
						
						
						{name : 'reg_no', type: 'String'  },
						
						{name : 'refname', type: 'String'  },
						
					
						 
						
						],
				    localdata: damagedata,
        
        
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
    
    
 
    
    $("#damageGrid").jqxGrid(
    {
        width: '98%',
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
        columns: [   
 

                  
                        { text: 'Doc NO', datafield: 'doc_no', width: '6%',editable:false},
					 { text: 'Date', datafield: 'date',editable:false, width: '8%',cellsformat:'dd.MM.yyyy'},
				     { text: 'Type', datafield: 'type', editable:false, width: '3%' }, 
				     { text: 'Ref Type',datafield: 'reftype',editable:false, width: '5%' },
				     { text: 'Ref Doc',datafield: 'refvoucherno',editable:false, width: '5%' },
					 { text: 'Fleet', datafield: 'rfleet', editable:false,width: '7%' },
					 { text: 'Reg No', datafield: 'reg_no', editable:false,width: '10%' },
					 { text: 'Client Name', datafield: 'refname', editable:false,width: '15%' },
					 { text: ' ', datafield: 'btnsave', width: '6%',columntype: 'button',editable:false, filterable: false,sortable:false},
					 { text: 'Action',datafield: 'action',editable:true,filterable: false,sortable:false, width: '9%' ,
						 cellsalign: 'center',align: 'center',columntype:'dropdownlist',createeditor: function (row, column, editor) {
		                       editor.jqxDropDownList({autoDropDownHeight: true,  enableBrowserBoundsDetection:true,source: list });
		                        
							
							},
						
							 cellbeginedit: function (row) {
									var temp=$('#damageGrid').jqxGrid('getcellvalue', row, "btnsave");
									 if (temp =="Edit")
									       return false;
								     
							                          }
					 },
					 
					 { text: 'Amount', datafield: 'amount', editable:true,filterable: false,sortable:false,sortable:false, cellsformat:'d2',cellsalign:"right",align:"right", width: '8%',
						 cellbeginedit: function (row) {
								var temp=$('#damageGrid').jqxGrid('getcellvalue', row, "btnsave");
								
								 if (temp =="Edit")
									
								       return false;
							     
						 },
						 
						 cellbeginedit: function (row) {
								var temp=$('#damageGrid').jqxGrid('getcellvalue', row, "action");
								 if (temp =="Way Off")
								       return false;
							     
						 }	 
					 
					 
					 
					 }, 
					
				     { text: 'Reason',datafield: 'reason',editable:true,filterable: false,sortable:false,  width: '18%',
						 cellbeginedit: function (row) {
								var temp=$('#damageGrid').jqxGrid('getcellvalue', row, "btnsave");
								 if (temp =="Edit")
								       return false;
							     
						 }
					 },

					
					 
					 { text: 'brhid', datafield: 'brhid', width: '6%',hidden:true},
					
					 { text: 'master Ref Doc',datafield: 'refdocno',editable:false, width: '6%',hidden:true },    
					]
   
    });

 
  $("#damageGrid").on('cellclick', function (event) 
    		{
	  $('#attachbtn').attr("disabled",false);	
	   var datafield = event.args.datafield;

	    var rowBoundIndex = event.args.rowindex;
	  document.getElementById("fleetno").value=$('#damageGrid').jqxGrid('getcellvalue',rowBoundIndex, "rfleet");
	  document.getElementById("docno").value=$('#damageGrid').jqxGrid('getcellvalue',rowBoundIndex, "doc_no");
	  
	  
    		 
    		    var columnindex = event.args.columnindex;

  			  if(columnindex>6)
  				  {
  				
  				  if($('#damageGrid').jqxGrid('getcellvalue',rowBoundIndex, "btnsave")=="Edit"){
  					  
  					 $.messager.alert('Message',' Click Edit Button ','warning');   
 		        	 
  					  }
  				  
  				  
  				  }
  			  
  			  if(datafield=="amount")
  		    {
  			   var act=$('#damageGrid').jqxGrid('getcellvalue', rowBoundIndex, "action");
  			   
  			   if(act=="Way Off")
        		      {
  				   $.messager.alert('Message','Amount Not Enter In Way Off ','warning');   
  				   
  			            			
        		      }
  			   }
  		
              if(datafield=="btnsave"){
            	 if($('#damageGrid').jqxGrid('getcellvalue',rowBoundIndex, "btnsave")=="Save")
            	 {
            		 var type= $('#damageGrid').jqxGrid('getcellvalue',rowBoundIndex, "type");
            		 var damagedate= $('#damageGrid').jqxGrid('getcelltext', rowBoundIndex, "date");
            		 var fleetno= $('#damageGrid').jqxGrid('getcellvalue',rowBoundIndex, "rfleet");
            		 var reftype=$('#damageGrid').jqxGrid('getcellvalue',rowBoundIndex, "reftype");
            		 var amount=$('#damageGrid').jqxGrid('getcellvalue',rowBoundIndex, "amount");
            		 var reason=$('#damageGrid').jqxGrid('getcellvalue',rowBoundIndex, "reason");
            		 var docno=$('#damageGrid').jqxGrid('getcellvalue',rowBoundIndex, "doc_no");
            		 var brnchid=$('#damageGrid').jqxGrid('getcellvalue',rowBoundIndex, "brhid");
            		var refdocno=$('#damageGrid').jqxGrid('getcellvalue',rowBoundIndex, "refdocno");
            		
            		var action=$('#damageGrid').jqxGrid('getcellvalue',rowBoundIndex, "action");
            		
            		
            		  if(action==null||typeof(action)=="undefined")
             		 {
             			
             			 $.messager.alert('Message','Select Action','warning');   
             			 return false; 
             			
             		 }
            	  if(action=="Chargeable")
         		 {
		                         
				            		  if(amount==null||typeof(amount)=="undefined")
				            		 {
				            			
				            			  $.messager.alert('Message','  Enter Amount ','warning'); 
						                  return false; 
				            			
				                     }
				            		             		  
         		 }	
            	  
            	  else
            		  {
            		  amount=0;
            		  }
            	  
            		 if(reason==""||typeof(reason)=="undefined")
            		 {
            			 
                          
            			 $.messager.alert('Message',' Enter reason','warning');   
            			  
            				return false; 
            		 }
           		 var nmax = reason.length;
            		
            		
     		           if(nmax>99)
     		        	   {
     		        	  $.messager.alert('Message',' Reason cannot contain more than 100 characters ','warning');   
     		        	
             				return false; 
     		        	 
     		        	   } 
     		          
     		           
     		          $.messager.confirm('Message', 'Do you want to save changes?', function(r){
     		        	  
     		       
     		        	if(r==false)
     		        	  {
     		        		return false; 
     		        	  }
     		        	else{
     		        	 savegriddata(damagedate,fleetno,reftype,amount,reason,docno,brnchid,refdocno,action,type);
     		        	}
     			     });
     		 	  
            	 }
            	 else {
            	
            	  $('#damageGrid').jqxGrid('setcellvalue',rowBoundIndex, "btnsave","Save");
            	 }
              }
    		   
    		}); 



                     
  $("#damageGrid").on('cellvaluechanged', function (event) 
		  {
		
		      var datafield = event.args.datafield;

		      var rowBoundIndex = event.args.rowindex;
			  if(datafield=="action")
	  		    {
	  			   var act=$('#damageGrid').jqxGrid('getcellvalue', rowBoundIndex, "action");
	  			   
	  			   if(act=="Way Off")
	        		      {
	  				
	  		       		$('#damageGrid').jqxGrid('setcellvalue',rowBoundIndex, "amount","");
	  			            			
	        		      }
	  			   }
	  		
		     
		  });
    
});

 function savegriddata(damagedate,fleetno,reftype,amount,reason,docno,brnchid,refdocno,action,type)
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
     x.open("GET","savegrid.jsp?damagedate="+damagedate+"&fleetno="+fleetno+"&reftype="+reftype+"&amount="+amount+"&reason="+reason+"&docno="+docno+"&brnchid="+brnchid+"&refdocno="+refdocno+"&action="+action+"&type="+type,true);
    x.send();
   
  
} 
</script>
<div id="damageGrid"></div>