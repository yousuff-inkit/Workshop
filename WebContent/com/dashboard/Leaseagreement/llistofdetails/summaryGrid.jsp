<%@ page import="com.dashboard.leaseagreement.ClsleaseagreementDAO" %>
 <%

   	String branch = request.getParameter("barchval")==null?"NA":request.getParameter("barchval");
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  	String cldocno = request.getParameter("cldocno")==null?"NA":request.getParameter("cldocno").trim();
  	String status = request.getParameter("status")==null?"NA":request.getParameter("status").trim();
  	String fleet = request.getParameter("fleet")==null?"NA":request.getParameter("fleet").trim();
  	String group = request.getParameter("group")==null?"NA":request.getParameter("group").trim();
  	String brand = request.getParameter("brand")==null?"NA":request.getParameter("brand").trim();
  	String model = request.getParameter("model")==null?"NA":request.getParameter("model").trim();
  	String outchk = request.getParameter("outchk")==null?"NA":request.getParameter("outchk").trim();
  	String inchk = request.getParameter("inchk")==null?"NA":request.getParameter("inchk").trim();
  	String id = request.getParameter("id")==null?"":request.getParameter("id").trim();
	ClsleaseagreementDAO leasedao=new ClsleaseagreementDAO();
 
 %> 
 <script type="text/javascript">
 
 var summarydata;
 var summaryexceldata;
 var aa;
 var id='<%=id%>';
  if(id=='1')
 { 
	  summarydata='<%=leasedao.getSummaryData(branch,fromdate,todate,cldocno,status,fleet,group,brand,model,outchk,inchk,id)%>';
 
	  summaryexceldata='<%=leasedao.getSummaryExcelData(branch,fromdate,todate,cldocno,status,fleet,group,brand,model,outchk,inchk,id)%>';
	
 aa=0;
 }
  
  
  else
	  {
	  summarydata;
	  aa=1;
	  }
         
        $(document).ready(function () { 
         
        	
            var source = 
            {
                datatype: "json",
                datafields: [

                             
                 			{name : 'cldocno', type: 'String'  },
                 			{name : 'refname', type: 'String'  },
     						{name : 'account', type: 'String'},     						
     						{name : 'contactperson', type: 'String'}, 
     						{name : 'sal_name', type: 'String'}, 
     						{name : 'agmtcount', type: 'String'  }
     										
                          	],
                          	localdata: summarydata,
                          	       
          
				
                
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
            $("#summaryGrid").jqxGrid(
            { 
            	
            	
            	width: '100%',
                height: 490,
                source: dataAdapter,
                showaggregates:true,
                enableAnimations: true,
                filtermode:'excel',
                filterable: true,
                sortable:true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                editable:false,
                columnsresize: true,
                
     					
                columns: [
                          
      
                          { text: 'SL#', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '5%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							  },
                          
							{ text: 'Code No', datafield: 'cldocno', width: '8%'}, 
							{ text: 'Client Name', datafield: 'refname', width: '28%' },             
							{ text: 'Account No', datafield: 'account', width: '8%' },
							{ text: 'Contact Person', datafield: 'contactperson', width: '22%'},
							{ text: 'Salesman', datafield: 'sal_name', width: '21%'},
							{ text: 'No of LA', datafield: 'agmtcount', width: '8%'}
					
					]
            });


     	   $("#overlay, #PleaseWait").hide();
       
        });
        
        
				       
                       
    </script>
    <div id="summaryGrid"></div>