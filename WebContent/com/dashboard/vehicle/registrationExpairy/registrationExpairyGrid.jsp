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
	
	 expdata='<%=cvd.regexpirysearch(barchval,expdate)%>'; 
	//alert(ssss);

} 
else
{ 
	
	expdata;

	}  
$(document).ready(function () {
   
	
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                     {name : 'fleet_no', type: 'String'  },
						{name : 'flname', type: 'String'  },
						 {name : 'reg_no', type: 'String'  }, 
						{name : 'reg_exp', type: 'date'  },
						 {name : 'reg_date', type: 'date'  }, 
						{name : 'gname', type: 'String'  },
						{name : 'model', type: 'String'  },
						{name : 'color', type: 'String'  },
						
						{name : 'brand_name', type: 'String'},
		        		{name : 'rem', type: 'string'  },
						{name : 'pno', type: 'string'  },
						
						{name : 'ex_date', type: 'date'  },
						{name : 'btnsave', type: 'String'  },
					
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
    
    
   
   
    
    $("#regexpgrid").jqxGrid(
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


				     { text: 'Fleet NO', datafield: 'fleet_no', editable:false, width: '5%' },
				     { text: 'Reg.NO', datafield: 'reg_no', editable:false, width: '5%' }, 
				     { text: 'Fleet Name',datafield: 'flname',editable:false, width: '14%' },
					 { text: 'Tariff Group', datafield: 'gname', editable:false,width: '6%' },
					 { text: 'Brand',datafield: 'brand_name', editable:false,width: '8%' },
					 { text: 'Model',datafield: 'model',editable:false, width: '8%' },
					 { text: 'Reg_Date', datafield: 'reg_date',editable:false, width: '6%',cellsformat:'dd.MM.yyyy'},
					 { text: 'Reg_Exp', datafield: 'reg_exp', width: '6%',editable:false,cellsformat:'dd.MM.yyyy'},
					 { text: 'Extended Date', datafield: 'ex_date', width: '9%',editable:true,columntype: 'datetimeinput',cellsformat:'dd.MM.yyyy',
						 cellbeginedit: function (row) {
								var temp=$('#regexpgrid').jqxGrid('getcellvalue', row, "btnsave");
								 if (temp =="Edit")
								       return false;
							     
						 }
					 },
					 { text: 'Remarks', datafield: 'rem', width: '21%',editable:true,
						 cellbeginedit: function (row) {
								var temp=$('#regexpgrid').jqxGrid('getcellvalue', row, "btnsave");
								 if (temp =="Edit")
								       return false;
							     
						 }},
					 { text: ' ', datafield: 'attachbtn', width: '6%',columntype: 'button',editable:false, filterable: false},
					 { text: ' ', datafield: 'btnsave', width: '6%',columntype: 'button',editable:false, filterable: false},
					 { text: 'docno', datafield: 'docno', width: '6%',hidden:true},
					 { text: 'brhid', datafield: 'brhid', width: '6%',hidden:true},
					
					
					
					]
   
    });

 
     $("#regexpgrid").on('cellclick', function (event) 
    		{
    		 
    		    var datafield = event.args.datafield;

    		    var rowBoundIndex = event.args.rowindex;
    		    var columnindex = event.args.columnindex;
  			  
    		  
       		 
  			  if(columnindex>7)
  				  {
  				  if(columnindex!=10 && columnindex!=11)
  					  {
  				  if($('#regexpgrid').jqxGrid('getcellvalue',rowBoundIndex, "btnsave")=="Edit"){
  					  
  					  
  					 $.messager.alert('Message',' Click Edit Button ','warning');   
 		        	 
  					
  					
  				            }
  				  
  					  }
  				  
  				  
  				  }
  			  
  			 if(datafield=="attachbtn"){
            	
            		 
            		 document.getElementById("docnoss").value=$('#regexpgrid').jqxGrid('getcellvalue',rowBoundIndex, "docno");
            		 
            		 document.getElementById("brh").value=$('#regexpgrid').jqxGrid('getcellvalue',rowBoundIndex, "brhid");
            		 
            		
            		 funAttachBtn();
            		 
            		 
  			 }
  			  
    		    
              if(datafield=="btnsave"){
            	 if($('#regexpgrid').jqxGrid('getcellvalue',rowBoundIndex, "btnsave")=="Save"){
            		
            		 var regexpdate= $('#regexpgrid').jqxGrid('getcelltext', rowBoundIndex, "reg_exp");
            		 var fleetno= $('#regexpgrid').jqxGrid('getcellvalue',rowBoundIndex, "fleet_no");
            		
            		 var exdate= $('#regexpgrid').jqxGrid('getcelltext', rowBoundIndex, "ex_date");
            		 var renval=$('#regexpgrid').jqxGrid('getcellvalue',rowBoundIndex, "rem");
            		
            	 	 
            		 var docno=$('#regexpgrid').jqxGrid('getcellvalue',rowBoundIndex, "docno");
            		 
            		 var brnchid=$('#regexpgrid').jqxGrid('getcellvalue',rowBoundIndex, "brhid");
            		 
            		
            		 if(exdate==null||typeof(exdate)=="undefined")
            		 {
            			
            			 $.messager.alert('Message','Enter Extended Date','warning');   
                        
            				return false; 
            			
            		 }
            		 if(renval==""||typeof(renval)=="undefined")
            		 {
            			 
                          
            			 $.messager.alert('Message',' Enter Remarks','warning');   
            			 
            			
            			  
            				return false; 
            		
            		 }  
            		 var nmax = renval.length;
            		
            		
     		           if(nmax>39)
     		        	   {
     		        	  $.messager.alert('Message',' Remarks cannot contain more than 40 characters ','warning');   
     		        	
             				return false; 
     		        	   
     		        	 
     		        	 
     		        	   } 
     		           
     		           
     		          $.messager.confirm('Message', 'Do you want to save changes?', function(r){
     		        	  
     		       
     		        	if(r==false)
     		        	  {
     		        		return false; 
     		        	  }
     		        	else{
     		        	 savegriddata(exdate,renval,fleetno,regexpdate,docno,brnchid);
     		        	}
     			     });
     		 	  
            	 }
            	 else {
            	
            	  $('#regexpgrid').jqxGrid('setcellvalue',rowBoundIndex, "btnsave","Save");
            	 }
              }
    		   
    		}); 

   

    
});



function funAttachBtn(){
	
	  $("#windowattach").jqxWindow('setTitle',"VEH - "+document.getElementById("docnoss").value);
		changeAttachContent("<%=contextPath%>/com/dashboard/Attach.jsp?formCode=VEH&docno="+document.getElementById("docnoss").value+"&barchvals="+document.getElementById("brh").value);		
	
}



function savegriddata(exdate,renval,fleetno,regexpdate,docno,brnchid)
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
     x.open("GET","saveGriddate.jsp?exdate="+exdate+"&remarks="+renval+"&fleetno="+fleetno+"&regexpdate="+regexpdate+"&docno="+docno+"&brnchid="+brnchid,true);
    x.send();
   
  
}
</script>

<input type="hidden" id="docnoss">
<input type="hidden" id="brh">

<div id="regexpgrid"></div>