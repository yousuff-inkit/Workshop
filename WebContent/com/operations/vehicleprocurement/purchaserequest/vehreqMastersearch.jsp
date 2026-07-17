<%@page import="com.operations.vehicleprocurement.purchaserequest.ClsvehpurchasereqDAO" %>
<%ClsvehpurchasereqDAO vpd=new ClsvehpurchasereqDAO(); %>
<%--  <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%-- <%
String branch=request.getParameter("branch")==null?"0":request.getParameter("branch");
%> --%>

<script type="text/javascript">

var vahReqmaster= '<%=vpd.SearchMasters(session) %>'; 
            	
        $(document).ready(function () { 	
        
 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
 
                            {name : 'voc_no', type: 'int'},
                            {name : 'doc_no', type: 'int'},
     						{name : 'date', type: 'date'  },
     						{name : 'type', type: 'string'   },
     						{name : 'expdeldt', type: 'date'   },
     						{name : 'desc1', type: 'string'  }
     						
     						
     											
                 ],
                 localdata: vahReqmaster,
                
                
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

            
            
            $("#vehreqMaster").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
             
                
          
          

                       
                columns: [
                           	{ text: 'masterdoc NO', datafield: 'doc_no', width: '10%' ,hidden:true},	
							{ text: 'Doc NO', datafield: 'voc_no', width: '10%' },	
							{ text: 'Date', datafield: 'date', width: '15%' ,cellsformat:'dd.MM.yyyy'},
							{ text: 'Type', datafield: 'type', width: '10%' },
							{ text: 'Description', datafield: 'desc1', width: '65%' },	
							{ text: 'expdeldt', datafield:'expdeldt', width: '10%',cellsformat:'dd.MM.yyyy',hidden:true}
							
			              ]
               
            });
            
            $('#vehreqMaster').on('rowdoubleclick', function (event) {
            
                var rowindex2 = event.args.rowindex;
                
     
                
                $('#vehpurreqDate').jqxDateTimeInput({ disabled: false});
                $('#vehexpDate').jqxDateTimeInput({ disabled: false});
                           	
           	
                   document.getElementById("docno").value =  $('#vehreqMaster').jqxGrid('getcellvalue', rowindex2, "voc_no");
                   document.getElementById("masterdoc_no").value =  $('#vehreqMaster').jqxGrid('getcellvalue', rowindex2, "doc_no");
                   
                   $('#vehpurreqDate').val ($('#vehreqMaster').jqxGrid('getcellvalue', rowindex2, "date"));
                   $('#vehexpDate').val( $('#vehreqMaster').jqxGrid('getcellvalue', rowindex2, "expdeldt")) ;
                
               
               
                   $('#cmbreftypeval').val($('#vehreqMaster').jqxGrid('getcellvalue', rowindex2, "type"));
                  document.getElementById("purdesc").value  = $('#vehreqMaster').jqxGrid('getcellvalue', rowindex2, "desc1");
             
                         
                    
                
                
              $('#window').jqxWindow('close'); 
         	 $('#vehpurreqDate').jqxDateTimeInput({ disabled: false });
        	 $('#vehpurreqDate').jqxDateTimeInput({ disabled: false});

        	  
        	
        	 funSetlabel();
            document.getElementById("frmvehpurReq").submit();
            }); 
              	  
   
        });
    </script>
    <div id="vehreqMaster"></div>
