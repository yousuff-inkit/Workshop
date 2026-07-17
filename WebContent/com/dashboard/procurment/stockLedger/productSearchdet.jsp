<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@page import="com.dashboard.procurment.stockLedger.*"%>
 <% ClsStockLedger searchDAO = new ClsStockLedger(); %>
<%
String product=request.getParameter("product")==null?"":request.getParameter("product");
String productname=request.getParameter("productname")==null?"":request.getParameter("productname");
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<script type="text/javascript">
 
$(document).ready(function () {
 
   var proddata=[];
   var id='<%=id%>';
   if(id=="1"){
	proddata='<%=searchDAO.productSearchDet(session,product,productname,id)%>';
   }
	   
	
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'prodcode',type:'String'},
                  		{name : 'prodname',type:'String'},
                  		{name : 'brand',type:'String'},
                  		
                  		
                  		],
				    localdata: proddata,
        
        
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
    
    
    $("#prodSearch1").jqxGrid(
    {
        width: '100%',
        height: 382,
        source: dataAdapter,
        showaggregates:true,
        showfilterrow: true, 
        filterable: true, 
         
        selectionmode: 'singlerow',
       sortable:false,
        columns: [
               
				
       				{ text: 'Doc No',datafield:'doc_no',width:'10%',hidden:true},
       				{ text:'Product Code',datafield:'prodcode',width:'35%'},
       				{ text:'Product Name',datafield:'prodname',width:'65%'},
       				 
       
                  
					]

    });
    $('#prodSearch1').on('rowdoubleclick', function (event) {
    	
        var rowindex1= event.args.rowindex;
        
        document.getElementById("name").value=$('#prodSearch1').jqxGrid('getcellvalue', rowindex1, "prodcode");
        document.getElementById("searchdetails1").value=$('#prodSearch1').jqxGrid('getcellvalue', rowindex1, "prodname");
        document.getElementById("psrno").value=$('#prodSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no");
        
      $('#productwindow1').jqxWindow('close'); 
    }); 
     
     
});

	
	
</script>

<div id="prodSearch1"></div>