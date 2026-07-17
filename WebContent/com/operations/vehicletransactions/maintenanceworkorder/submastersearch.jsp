  
 
 
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>



<%@ page import="com.operations.vehicletransactions.maintenanceworkorder.ClsmaintWorkorderDAO" %>
<%ClsmaintWorkorderDAO cmwd=new ClsmaintWorkorderDAO(); %>


<%

String fleetnoss = request.getParameter("fleetnoss")==null?"NA":request.getParameter("fleetnoss");
String seachdoc = request.getParameter("seachdoc")==null?"NA":request.getParameter("seachdoc");
String flnames = request.getParameter("flnames")==null?"NA":request.getParameter("flnames");
String regnoss = request.getParameter("regnoss")==null?"NA":request.getParameter("regnoss");
String aa = request.getParameter("aa")==null?"NA":request.getParameter("aa");

String formdetailcode = request.getParameter("formdetailcode")==null?"NA":request.getParameter("formdetailcode");
	// System.out.println("-----formdetailcode----"+formdetailcode);
%>

  
 <script type="text/javascript">

   var master='<%=cmwd.searchMaster(session,fleetnoss,seachdoc,flnames,regnoss,aa,formdetailcode)%>';

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
     						{name : 'invno', type: 'String' },	
     						
     						{name : 'postdate', type: 'date' },
     						
     						
     						{name : 'wostatus' , type: 'int' },
     						{name : 'apstatus' , type: 'int' },
     						{name : 'psstatus' , type: 'int' },
     						
     						
     						{name : 'statuss' , type: 'string' },
     						
     						// wostatus apstatus psstatus
     						
     				                        	
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
                height: 294,
                source: dataAdapter,
 
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
					{ text: 'invdate', datafield: 'invdate', width: '15%' ,hidden:true },
					
					{ text: 'postdate', datafield: 'postdate', width: '15%' ,hidden:true },
					 
					
					{ text: 'wostatus', datafield: 'wostatus', width: '15%' ,hidden:true },
					{ text: 'apstatus', datafield: 'apstatus', width: '15%' ,hidden:false },
					{ text: 'psstatus', datafield: 'psstatus', width: '15%' ,hidden:true },
					{ text: 'statuss', datafield: 'statuss', width: '15%' ,hidden:true },
					
					
					// wostatus apstatus psstatus
					
					]
            });
            
            $('#mastersearch').on('rowdoubleclick', function (event) 
            		{ 
            
            	  var rowBoundIndex = event.args.rowindex; 
            	   	$('#maintainceDate').jqxDateTimeInput({ disabled: false});
  	               $('#invDate').jqxDateTimeInput({ disabled: false});
  	               
  	               
  	             $('#postDate').jqxDateTimeInput({ disabled: false});
  	               
  	               
            	    $('#mtfleetno').attr('disabled', false);
                	$('#garagemaster').attr('disabled', false);
            	       $('#maintainceDate').val($("#mastersearch").jqxGrid('getcellvalue', rowBoundIndex, "date")) ;
            	       document.getElementById("masterdoc_no").value= $('#mastersearch').jqxGrid('getcelltext', rowBoundIndex, "masterdoc");
            		 document.getElementById("docno").value= $('#mastersearch').jqxGrid('getcelltext', rowBoundIndex, "vocno");
            		


					   $('#invDate').val($("#mastersearch").jqxGrid('getcellvalue', rowBoundIndex, "invdate")) ;
					   
					   $('#postDate').val($("#mastersearch").jqxGrid('getcellvalue', rowBoundIndex, "postdate")) ;
					   
					   
					   
					   
					document.getElementById("invno").value= $('#mastersearch').jqxGrid('getcelltext', rowBoundIndex, "invno");
					            		 
					//workstatus apprstatus postingstatus// 
					            		 
					document.getElementById("workstatus").value= $('#mastersearch').jqxGrid('getcelltext', rowBoundIndex, "wostatus");
					document.getElementById("apprstatus").value= $('#mastersearch').jqxGrid('getcelltext', rowBoundIndex, "apstatus");
					document.getElementById("postingstatus").value= $('#mastersearch').jqxGrid('getcelltext', rowBoundIndex, "psstatus");
					document.getElementById("formstatus").value= $('#mastersearch').jqxGrid('getcelltext', rowBoundIndex, "statuss");
					
 
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
            	document.getElementById("approvalstatus").value= $('#mastersearch').jqxGrid('getcelltext', rowBoundIndex, "apstatus");
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