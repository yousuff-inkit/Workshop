<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.operations.agreement.rentalagreement.ClsRentalAgreementDAO" %>
<%

String vehgpid= request.getParameter("vehgpid")==null?"0":request.getParameter("vehgpid").trim();
String cldocno= request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();

String outdate= request.getParameter("outdate")==null?"NA":request.getParameter("outdate").trim();
String outtime= request.getParameter("outtime")==null?"NA":request.getParameter("outtime").trim();

ClsRentalAgreementDAO viewDAO= new ClsRentalAgreementDAO();
 
%>


 <script type="text/javascript">
    
 var datatasr= '<%=viewDAO.weekendtrariffbtnGrid(session,vehgpid,cldocno,outdate,outtime)%>';
       // alert(data);
        $(document).ready(function () { 	
        	
             var num = 1; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
                            {name : 'doc_no', type: 'string'  },
     						{name : 'validto', type: 'string'    },
     						{name : 'tariftype', type: 'string'    },
     						
     					   {name : 'insurexcess', type: 'number'  },                     
    						{name : 'cdwexcess', type: 'number'    },
    						{name : 'scdwexcess', type: 'number'    },
     						
     					     						
                 ],               
                localdata: datatasr,
             
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

            
            
            $("#getweekend").jqxGrid(
            {
                width: '100%',
                height: 277,
                source: dataAdapter,
                columnsresize: true,
          
                altRows: true,
                /* showfilterrow: true, */
                /* filterable: true, */ 
               // sortable: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                
                //Add row method
            /*     handlekeyboardnavigation: function (event) {
                    var cell = $('#jqxgrid2').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'NAME' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#jqxgrid2").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
                },
                 */
                //Filter
                /* ready: function () {
                    addfilter();
                }, */
                
                
                columns: [
                           
                          
               		
                          
                          
							{ text: 'Doc no', datafield: 'doc_no', width: '10%' },
							{ text: 'Name', datafield: 'tariftype', width: '60%' },
							{ text: 'Valid TO', datafield: 'validto', width: '30%' },
							
							{ text: 'insurexcess', datafield: 'insurexcess', width: '10%',cellsformat:'d2',hidden:true },
							{ text: 'cdwexcess', datafield: 'cdwexcess', width: '10%',cellsformat:'d2',hidden:true  },
							{ text: 'scdwexcess TO', datafield: 'scdwexcess', width: '10%' ,cellsformat:'d2',hidden:true },
						
						
	              ]
            });
            $('#getweekend').on('rowdoubleclick', function (event) 
            		{ 
              	var rowindex1=event.args.rowindex;
              	var indexVal = $('#getweekend').jqxGrid('getcellvalue', rowindex1, "doc_no");
              	
                document.getElementById("ratariffdocno1").value=indexVal;
                
                 
                  
                  var exinsuss=$('#getweekend').jqxGrid('getcellvalue', rowindex1, "insurexcess");
                  var aa="excessinsur";
                  funRoundAmt(exinsuss,aa);
                  
                document.getElementById("normalinsu").value=$('#getweekend').jqxGrid('getcellvalue', rowindex1, "insurexcess");
                document.getElementById("cdwinsu").value=$('#getweekend').jqxGrid('getcellvalue', rowindex1, "cdwexcess");
                document.getElementById("supercdwinsu").value=$('#getweekend').jqxGrid('getcellvalue', rowindex1, "scdwexcess");
                
                 var vehGroup=document.getElementById("veh_fleetgrouptariff").value; 
       /*    alert(vehGroup); */
              
                $("#tariffDivId").load('rateDescription.jsp?weekdoc='+indexVal+'&weekGroup='+vehGroup+'&outdate='+'<%=outdate%>'+'&outtime='+'<%=outtime%>');
                
                document.getElementById("errormsg").innerText="";  
                $('#tariffinbtnwindow').jqxWindow('close');
                
      
              
            		});
          
       	  
         
        });
    </script>
    <div id="getweekend"></div>
<!--  <input type="hidden" id="rowindex"/>  -->