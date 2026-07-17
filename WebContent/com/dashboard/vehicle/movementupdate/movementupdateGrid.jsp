<%@ page import="com.dashboard.vehicle.movementupdate.ClsMovementUpdateDAO" %>
<% ClsMovementUpdateDAO cmud=new ClsMovementUpdateDAO();%>

<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>   --%>

 <%
    String fleetno = request.getParameter("fleetno")==null?"NA":request.getParameter("fleetno").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
 
 %> 
           	  
 <style type="text/css">
        .redClass
        {
            color: red;
        }
        .yellowClass
        {
            color: green;
        }
       </style>
<script type="text/javascript">


 
 var temp4='<%=fleetno%>';
var datamov;

 if(temp4!='NA')
{ 
	
	 datamov='<%=cmud.searchmovement(fleetno,fromdate,todate)%>'; 
	 
} 
else
{ 
	
	datamov;

	
	}  
 
$(document).ready(function () {
 
    var source =
    {
        datatype: "json",
        datafields: [   
                     
   
                  
                     
                        {name : 'rdtype', type: 'String'  },
						{name : 'rdocno', type: 'string'  },
						{name : 'flname', type: 'String'  },
						{name : 'status', type: 'String'  },
						{name : 'trancode', type: 'String'  },
					 
						{name : 'dout', type: 'date'},
						{name : 'tout', type: 'String'},
						{name : 'kmout', type: 'String'  },
					
						{name : 'fout', type: 'string'  },
					 
						
	
						{name : 'din', type: 'date'},
						{name : 'tin', type: 'String'},
						{name : 'kmin', type: 'String'},
						{name : 'fin', type: 'String'  },
						{name : 'fleet_no', type: 'String'},
						{name : 'reg_no', type: 'String'  },
						
						
						{name : 'hidfin', type: 'String'  },
						{name : 'hidfout', type: 'String'  },
					
						{name : 'vmrdocno', type: 'String'  },
						{name : 'doc_no', type: 'String'  },
						 
						
						],
				    localdata: datamov,
        
        
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
    
    var cellclassname = function (row, column, value, data) {
        if (row>0) {
                  return "redClass";
                  }
             
              else{
               return "yellowClass";
              };
          };
    
  

          
         
   
    
    $("#vehmovement").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columns: [   
                  
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '3%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }  
					  }, 
					
              	 { text: 'Fleet', datafield: 'fleet_no',  width: '8%',cellclassname: cellclassname }, 
              	 { text: 'Reg No', datafield: 'reg_no',  width: '5%',cellclassname: cellclassname }, 
           	         { text: 'Type', datafield: 'rdtype',  width: '4%' ,cellclassname: cellclassname}, 
					 { text: 'Ref No', datafield: 'rdocno', width: '4%',cellclassname: cellclassname},
					 { text: 'Name', datafield: 'flname', width: '14%',cellclassname: cellclassname},
				     { text: 'Status',datafield: 'status', width: '5%' ,cellclassname: cellclassname},
				     { text: 'Trancode',datafield: 'trancode', width: '11%' ,cellclassname: cellclassname},
 					 { text: 'Date Out', datafield: 'dout', width: '6%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
					 { text: 'Time Out', datafield: 'tout', width: '5%',cellclassname: cellclassname},
					 { text: 'KM Out', datafield: 'kmout', width: '6%',cellclassname: cellclassname},
					 { text: 'Fuel Out', datafield: 'fout', width: '6%',cellclassname: cellclassname},
			    	 { text: 'Date In', datafield: 'din', width: '6%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
					 { text: 'Time In', datafield: 'tin', width: '5%',cellclassname: cellclassname},
					 { text: 'KM In', datafield: 'kmin', width: '6%',cellclassname: cellclassname},
					 { text: 'Fuel In', datafield: 'fin', width: '6%',cellclassname: cellclassname},
					 
					 { text: 'hidFuel Out', datafield: 'hidfout', width: '8%',hidden:true},
					 
					 { text: 'hidFuel in', datafield: 'hidfin', width: '8%',hidden:true},
					 { text: 'vmrdocno', datafield: 'vmrdocno', width: '4%',hidden:true},
					 { text: 'docnos', datafield: 'doc_no', width: '4%',hidden:true},
					 
					]
   
    });
    
/*     dateout timeout outkm outfuel datein timeout inkm infuel */
    $("#overlay, #PleaseWait").hide();
    
  
    $('#vehmovement').on('rowdoubleclick', function (event) 
    		{ 
    	
     	  var rowindex1=event.args.rowindex;
    	
     	  
     	  if(rowindex1>0)
     		  {
     		  
               return 0;   		  
     		  
     		  }
     	  
     	  var rano=$('#vehmovement').jqxGrid('getcellvalue', rowindex1, "vmrdocno");
     	  var rdtype=$('#vehmovement').jqxGrid('getcellvalue', rowindex1, "rdtype");
     	  
     	 var x=new XMLHttpRequest();
     	x.onreadystatechange=function(){
     		
     		if(x.readyState==4 && x.status==200)
     			
     			{
     			
     			var temp=x.responseText;
     			
     			if(parseInt(temp)==1)
     				{
     				  $.messager.alert('Message','Update Not Possible-Invoice Generated','warning'); 
     	  
     				   return 0;
     				
     				}
     			
     			else
     				{
     				if(rdtype=="MOV"||rdtype=="VSC")
     					{
     					
     				 $("#deletedata").attr("disabled", false);
     				 
     					}
     				else
     					{
     					 $("#deletedata").attr("disabled", true);
     					}
     				
     		     	 document.getElementById("status").value="";
     		        document.getElementById("outkm").value=$('#vehmovement').jqxGrid('getcellvalue', rowindex1, "kmout");
     		        document.getElementById("outfuel").value=$('#vehmovement').jqxGrid('getcellvalue', rowindex1, "hidfout");
     		        $('#dateout').val($('#vehmovement').jqxGrid('getcellvalue', rowindex1, "dout")) ; 
     		        $('#timeout').val($('#vehmovement').jqxGrid('getcellvalue', rowindex1, "tout")) ; 
     		       
     		       
     		        document.getElementById("inkm").value=$('#vehmovement').jqxGrid('getcellvalue', rowindex1, "kmin");
     		        document.getElementById("infuel").value=$('#vehmovement').jqxGrid('getcellvalue', rowindex1, "hidfin");
     		        $('#datein').val($('#vehmovement').jqxGrid('getcellvalue', rowindex1, "din")) ; 
     		        $('#timein').val($('#vehmovement').jqxGrid('getcellvalue', rowindex1, "tin")) ; 
     		        
     		        var statu=$('#vehmovement').jqxGrid('getcellvalue', rowindex1, "status");
     		        document.getElementById("status").value=statu;
     		        $("#out *").attr("disabled", false);
     		   	 $("#savedata").attr("disabled", false);
     			 $('#dateout').jqxDateTimeInput({ disabled: false});
     		        if(statu=="OUT")
     		        	{
     		        	
     		        	$("#in *").attr("disabled", "disabled");
     		        	 $('#datein').jqxDateTimeInput({ disabled: true});
     		        	}
     		        else
     		        	{
     		        	
     		        	$("#in *").attr("disabled", false);
     		        	 $('#datein').jqxDateTimeInput({ disabled: false});
     		        	}
     		        document.getElementById("vmrdocno").value=$('#vehmovement').jqxGrid('getcellvalue', rowindex1, "vmrdocno");
     		        document.getElementById("vmdocno").value=$('#vehmovement').jqxGrid('getcellvalue', rowindex1, "doc_no");
     		        
     		       document.getElementById("dtype").value=$('#vehmovement').jqxGrid('getcellvalue', rowindex1, "rdtype");
     		  // 	var dtype=document.getElementById("dtype").value;
     		        
     				
     				}
     	  
     			}
    		
    	}
    	x.open("GET","checkinv.jsp?rano="+rano+"&rdtype="+rdtype); 
    			  x.send();
     	  
     	  
     	  
     	  
    
      
    	
    		 });	 
     
  
});


</script>
<div id="vehmovement"></div>