
 
 
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
  <%@page import="com.operations.vehicletransactions.maintenanceupdate.ClsmaintenanceDAO" %>
 
 
 <%
 ClsmaintenanceDAO viewDAO=new ClsmaintenanceDAO();  
 
 
 %>
 <script type="text/javascript">

   var master='<%=viewDAO.searchMaster(session)%>';

        $(document).ready(function () { 	
            
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [


							{name : 'masterdoc' , type: 'int' },
                          	{name : 'vocno' , type: 'int' },
                          	{name : 'fleetno', type: 'String' },
     						{name : 'flname', type: 'String'  },
     						{name : 'date', type: 'date' },
     						{name : 'mtype', type: 'String'  },
     						{name : 'currkm', type: 'String' },
     						{name : 'serduekm', type: 'String'  },
     						{name : 'gargid', type: 'String' },
     						{name : 'name', type: 'String'  },
     						{name : 'remarks', type: 'String' },
     						{name : 'tlabcost', type: 'String'  },
     						{name : 'tpartcost', type: 'String' },
     						{name : 'tcost', type: 'String'  },
     						{name : 'trno', type: 'int'  },
     						{name : 'jvmdoc', type: 'int'  },
     						{name : 'reg_no', type: 'String'  },
     							{name : 'invdate', type: 'date' },
     						{name : 'invno', type: 'int' },	
     				                        	
                          	],
             
                          	localdata: master,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#mastersearch").jqxGrid(
            {
                width: '99.9%',
                height: 350,
                source: dataAdapter,
            
                filterable: true,
                showfilterrow: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
              
                //masterdoc vocno     
	
                columns: [
					{ text: 'masterDOC NO', datafield: 'masterdoc', width: '10%',hidden:true},
					{ text: 'DOC NO', datafield: 'vocno', width: '10%'},
					{ text: 'FLEET NO', datafield: 'fleetno', width: '15%' },
					{ text: 'REG NO', datafield: 'reg_no', width: '15%' },
					{ text: 'NAME', datafield: 'flname', width: '60%'  },
					{ text: 'date', datafield: 'date', width: '10%',hidden:true},
					{ text: 'mtype', datafield: 'mtype', width: '15%' ,hidden:true},
					{ text: 'currkm', datafield: 'currkm', width: '15%' ,hidden:true },
					{ text: 'serduekm', datafield: 'serduekm', width: '10%',hidden:true},
					{ text: 'gargid', datafield: 'gargid', width: '15%' ,hidden:true},
					{ text: 'Garage name', datafield: 'name', width: '15%'  ,hidden:true},
					{ text: 'Remark', datafield: 'remarks', width: '10%',hidden:true},
					{ text: 'Lab Cost', datafield: 'tlabcost', width: '15%',hidden:true },
					{ text: 'Parts', datafield: 'tpartcost', width: '15%' ,hidden:true },
					{ text: 'Total', datafield: 'tcost', width: '15%' ,hidden:true },
					{ text: 'Tranno', datafield: 'trno', width: '15%' ,hidden:true },
					{ text: 'jamdoc', datafield: 'jvmdoc', width: '15%' ,hidden:true },
					{ text: 'invno', datafield: 'invno', width: '15%' ,hidden:true },
					{ text: 'invdate', datafield: 'invdate', width: '15%' ,hidden:true }
					
					]
            });
            
            $('#mastersearch').on('rowdoubleclick', function (event) 
            		{ 
            
            	  var rowBoundIndex = event.args.rowindex; 
            	   	$('#maintainceDate').jqxDateTimeInput({ disabled: false});
  	$('#invDate').jqxDateTimeInput({ disabled: false});
            	    $('#mtfleetno').attr('disabled', false);
                	$('#garagemaster').attr('disabled', false);
            	       $('#maintainceDate').val($("#mastersearch").jqxGrid('getcellvalue', rowBoundIndex, "date")) ;
            	       document.getElementById("masterdoc_no").value= $('#mastersearch').jqxGrid('getcelltext', rowBoundIndex, "masterdoc");
            		 document.getElementById("docno").value= $('#mastersearch').jqxGrid('getcelltext', rowBoundIndex, "vocno");
            		


   $('#invDate').val($("#mastersearch").jqxGrid('getcellvalue', rowBoundIndex, "invdate")) ;
document.getElementById("invno").value= $('#mastersearch').jqxGrid('getcelltext', rowBoundIndex, "invno");
            		 

 
            	document.getElementById("mtfleetno").value= $('#mastersearch').jqxGrid('getcelltext', rowBoundIndex, "fleetno");
            	document.getElementById("mtflname").value= $('#mastersearch').jqxGrid('getcelltext', rowBoundIndex, "flname");
            	//maintainceDate,maintype,currkm,nextserdue,garagemaster,garrageid,lbrtotalcost,partstotalcost,totalcost
            	
            
             	document.getElementById("mtremark").value= $('#mastersearch').jqxGrid('getcelltext', rowBoundIndex, "remarks");
             	//document.getElementById("mtfleetno").value= $('#mastersearch').jqxGrid('getcelltext', rowBoundIndex, "fleet_no");
            	document.getElementById("maintypeval").value= $('#mastersearch').jqxGrid('getcelltext', rowBoundIndex, "mtype");
            	document.getElementById("currkm").value= $('#mastersearch').jqxGrid('getcelltext', rowBoundIndex, "currkm");
            	document.getElementById("nextserdue").value= $('#mastersearch').jqxGrid('getcelltext', rowBoundIndex, "serduekm");
            	document.getElementById("garagemaster").value= $('#mastersearch').jqxGrid('getcelltext', rowBoundIndex, "name");
            	document.getElementById("garrageid").value= $('#mastersearch').jqxGrid('getcelltext', rowBoundIndex, "gargid");
            	
            	
             	document.getElementById("lbrtotalcost").value= $('#mastersearch').jqxGrid('getcelltext', rowBoundIndex, "tlabcost");
            	document.getElementById("partstotalcost").value= $('#mastersearch').jqxGrid('getcelltext', rowBoundIndex, "tpartcost");
            	document.getElementById("totalcost").value= $('#mastersearch').jqxGrid('getcelltext', rowBoundIndex, "tcost");
            	document.getElementById("maintTrno").value= $('#mastersearch').jqxGrid('getcelltext', rowBoundIndex, "trno");
            	
            	document.getElementById("jvmDovno").value= $('#mastersearch').jqxGrid('getcelltext', rowBoundIndex, "jvmdoc");
            	
                $('#window').jqxWindow('close');
                $('#mtfleetno').attr('disabled', false);
            	$('#garagemaster').attr('disabled', false);
            	$('#frmmaint select').attr('disabled', false);
           	   funSetlabel();
               document.getElementById("frmmaint").submit();
            	
            		 }); 
      
        });
    </script>
    <div id="mastersearch"></div>