<%-- <%
String item = request.getParameter("item")==null?"NA":request.getParameter("item");

%> --%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.invoices.lease.*" %>
 <%
 ClsLeaseInvoiceDAO rentaldao=new ClsLeaseInvoiceDAO();
 String client = request.getParameter("client")==null?"":request.getParameter("client");
 String mobile = request.getParameter("mobile")==null?"":request.getParameter("mobile");
 String date = request.getParameter("date")==null?"":request.getParameter("date");
 String fleetno = request.getParameter("fleetno")==null?"":request.getParameter("fleetno");
 String regno = request.getParameter("regno")==null?"":request.getParameter("regno");
 String docno = request.getParameter("docno")==null?"":request.getParameter("docno");
 String branch = request.getParameter("branch")==null?"":request.getParameter("branch");
 String id=request.getParameter("id")==null?"0":request.getParameter("id");
%> 

 <script type="text/javascript">
 
 var agmtdata;
<%--  if('NA' != '<%=item%>')  {
	 radata = '<%=item%>';
 } 
  --%>
  var id='<%=id%>';
  if(id=="1"){ 
	  agmtdata='<%=rentaldao.getAgmtData(client,mobile,date,fleetno,regno,docno,branch,id)%>';
  }
  else{
	  
  }
        $(document).ready(function () { 
         
            var source = 
            {
                datatype: "json",
                datafields: [
 
     						{name : 'refname', type: 'String'  },
     						{name : 'per_mob', type: 'String'  },
     						{name : 'doc_no', type: 'number'  },
     						{name : 'voc_no', type: 'number'  },
     						{name : 'date', type: 'date'},
     						{name : 'fleet_no', type: 'number'  },
     						{name : 'reg_no', type: 'number'  },
     						{name : 'branch', type: 'string' }
     						
      					
     						
                          	],
                          	localdata: agmtdata,
                          
                
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
            $("#agmtSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
            
            
     					
                columns: [
					{ text: 'Doc No Original', datafield: 'doc_no', width: '7%',hidden:true },
					{ text: 'Doc No', datafield: 'voc_no', width: '15%'},
					{ text: 'Date', datafield: 'date', width: '15%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Client', datafield: 'refname', width: '25%' },
					{ text: 'Fleet No', datafield: 'fleet_no', width: '15%' },
					{ text: 'Reg No', datafield: 'reg_no', width: '15%' },
					{ text: 'Mobile', datafield: 'per_mob', width: '15%' }
				
					]
            });
 
				           $('#agmtSearchGrid').on('rowdoubleclick', function (event) 
				            		{ 
				        		var rowindex1=event.args.rowindex;
				            	document.getElementById("agmtno").value=$('#agmtSearchGrid').jqxGrid('getcellvalue', rowindex1, "voc_no"); 
				            	document.getElementById("hidagmtno").value=$('#agmtSearchGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
				              $('#agmtwindow').jqxWindow('close');
				            		 }); 	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="agmtSearchGrid"></div>
   