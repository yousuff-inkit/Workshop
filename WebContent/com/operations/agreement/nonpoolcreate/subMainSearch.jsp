<%-- <%
String item1 = request.getParameter("item1")==null?"NA":request.getParameter("item1");

%> --%>
<%@page import="com.operations.agreement.nonpoolcreate.ClsNonPoolCreateDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 ClsNonPoolCreateDAO nonpooldao=new ClsNonPoolCreateDAO();
 String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
 String date=request.getParameter("date")==null?"":request.getParameter("date");
 String vendor=request.getParameter("vendor")==null?"0":request.getParameter("vendor");
 String fleetno = request.getParameter("fleetno")==null?"0":request.getParameter("fleetno");
 String regno = request.getParameter("regno")==null?"0":request.getParameter("regno");
 String mobile=request.getParameter("mobile")==null?"0":request.getParameter("mobile");
 String branch=request.getParameter("branch")==null?"0":request.getParameter("branch");
%> 
 <script type="text/javascript">
 var temp='<%=request.getParameter("id")==null?"0":request.getParameter("id")%>';
  var subsearchdata;
if(temp=="1"){
	<%System.out.println("Inside Search in jsp");%>
	subsearchdata='<%=nonpooldao.getSearchData(docno,date,vendor,fleetno,regno,mobile,branch)%>';	
}
else{
	
}
 
               
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                             

                         	
							{name : 'doc_no' , type: 'string' },
							{name : 'voc_no',type:'string'},
							{name : 'edate' , type:'date'},
							{name : 'refname' , type: 'String' },
     						{name : 'fleet_no', type: 'String'  },
     						{name : 'reg_no', type: 'String'  },
     						{name : 'per_mob', type: 'String'  }
      						
      						
                          	],
                          	localdata: subsearchdata,
                          
          
				
                
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
            $("#jqxmainsearch").jqxGrid(
            {
                width: '100%',
                height: 280,
                source: dataAdapter,
                columnsresize: true,

                selectionmode: 'singlerow',
             
               
                //Add row method
	
     						
     					
     					
                columns: [
				
				{ text: 'Master Doc No', datafield: 'doc_no', width: '10%',hidden:true},
				{ text: 'Doc No', datafield: 'voc_no', width: '10%'},
				{ text: 'Date',  datafield: 'edate',  width: '10%',cellsformat:'dd.MM.yyyy'},
				{ text: 'Fleet No',datafield: 'fleet_no', width: '10%' },
				{ text: 'Reg No', datafield: 'reg_no', width: '10%' },
				{ text: 'Vendor', datafield: 'refname', width: '50%' },
				{ text: 'Mobile', datafield: 'per_mob', width: '10%' }
				
					 
			
					
					
					]
            });
    
      
				            
				          $('#jqxmainsearch').on('rowdoubleclick', function (event) 
				            		{ 
				        		var rowindex1=event.args.rowindex;
				                document.getElementById("fleetno").value= $('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "fleet_no"); 
				                document.getElementById("docno").value= $('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
				                $('#window').jqxWindow('close');
				                funSetlabel();
				                document.getElementById("frmNonPoolCreate").submit(); 
				            		 });	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxmainsearch"></div>
    
