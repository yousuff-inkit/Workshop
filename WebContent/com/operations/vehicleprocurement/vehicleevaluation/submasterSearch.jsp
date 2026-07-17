<%@page import="com.operations.vehicleprocurement.vehicleevaluation.ClsVehicleEvaluationDAO" %>
<% ClsVehicleEvaluationDAO cid=new ClsVehicleEvaluationDAO();%>

<%--  <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String docnoss = request.getParameter("docnoss")==null?"NA":request.getParameter("docnoss");
String client = request.getParameter("client")==null?"NA":request.getParameter("client");


String datess = request.getParameter("datess")==null?"0":request.getParameter("datess");
String chno = request.getParameter("chno")==null?"0":request.getParameter("chno");
 

 String aa = request.getParameter("aa")==null?"NA":request.getParameter("aa"); 
 
/*  String brchName = request.getParameter("brchName")==null?"0":request.getParameter("brchName");  */
 
 
 %>
<script type="text/javascript">

var vahOrdermaster1= '<%=cid.searchmaster(session,docnoss,client,datess,chno,aa) %>'; 
            	
        $(document).ready(function () { 	
        
 
                     
            //  prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                             
                             
                        /*      refmaster voc_no */
                             
                             
                             
                             
     						{name : 'doc_no', type: 'int'},
     						{name : 'date', type: 'date'  },
     						{name : 'refname', type: 'string'   },
     						{name : 'chno', type: 'string'   },
     						{name : 'model', type: 'string'   },
     						{name : 'cldocno', type: 'number'   },
     						{name : 'engineno', type: 'string'   },
     						{name : 'carvalue', type: 'number'   },
     						{name : 'odkm', type: 'number'   }     						
     						
     											
                 ],
                 localdata: vahOrdermaster1,
                
                
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

            
            
            $("#vehevaluationMaster").jqxGrid(
            {
                width: '100%',
                height: 283,
                source: dataAdapter,
             
                selectionmode: 'singlerow',
             
                
          
          

                       
                columns: [

                                  	
                          	
							{ text: 'Doc NO', datafield: 'doc_no', width: '12%' },	
							{ text: 'Date', datafield: 'date', width: '20%' ,cellsformat:'dd.MM.yyyy'},
							{ text: 'Client', datafield: 'refname', width: '21%' },
							{ text: 'chassis No', datafield: 'chno', width: '22%' },
							{ text: 'Model', datafield: 'model', width: '25%' },
							{ text: 'Clientid', datafield: 'cldocno', width: '10%',hidden:true },	
							{ text: 'Engine NO', datafield: 'engineno', width: '25%',hidden:true },
							{ text: 'Carvalue', datafield: 'carvalue', width: '40%',hidden:true },	
							
							{ text: 'Odo_metre', datafield: 'odkm', width: '65%' ,hidden:true },
						 ]
               
            });
            
            $('#vehevaluationMaster').on('rowdoubleclick', function (event) {
            
                var rowindex2 = event.args.rowindex;
                 $('#vehrefno').attr('disabled', false);
     
                $('#jqxDate1').jqxDateTimeInput({disabled: false});
    		
                           	
    			 
                   document.getElementById("docno").value =  $('#vehevaluationMaster').jqxGrid('getcellvalue', rowindex2, "doc_no");
                   
                   $('#jqxDate1').val ($('#vehevaluationMaster').jqxGrid('getcellvalue', rowindex2, "date"));
                  
                   document.getElementById("txtclientname").value =  $('#vehevaluationMaster').jqxGrid('getcellvalue', rowindex2, "refname");
                   document.getElementById("txtcldocno").value =  $('#vehevaluationMaster').jqxGrid('getcellvalue', rowindex2, "cldocno");
                   
                   document.getElementById("txtchno").value  = $('#vehevaluationMaster').jqxGrid('getcellvalue', rowindex2, "chno");
                   
                   
                   document.getElementById("model").value =  $('#vehevaluationMaster').jqxGrid('getcellvalue', rowindex2, "model");
                   document.getElementById("txtengno").value =  $('#vehevaluationMaster').jqxGrid('getcellvalue', rowindex2, "engineno");
                   document.getElementById("carval").value =  $('#vehevaluationMaster').jqxGrid('getcellvalue', rowindex2, "carvalue");
                  document.getElementById("txtodno").value  = $('#vehevaluationMaster').jqxGrid('getcellvalue', rowindex2, "odkm");
              
                         
                    
                
                
              $('#window').jqxWindow('close'); 
         	 
        	
        	
        	// funSetlabel();
            document.getElementById("frmVehicleevaluation").submit();
            }); 
              	  
   
        });
    </script>
    <div id="vehevaluationMaster"></div>
