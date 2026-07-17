<%@page import="com.operations.marketing.enquiry.ClsEnquiryDAO" %>

       

       <%
       
       ClsEnquiryDAO viewDAO=new ClsEnquiryDAO();
       %>
       <script type="text/javascript">
 
       /*    var temp=document.getElementById("txtcusid").value;
		if(temp>0)
			{
			var url1='disDriver.jsp?clientid='+temp;
			
			}
		else
			{
			var url1;
			} */
			 var barnddata= '<%=viewDAO.searchBrand() %>';
			 
			 
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'brand', type: 'string'  },
                            {name : 'brand_name', type: 'string'  },
                            {name : 'doc_no', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: barnddata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxbrandSearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
             
                selectionmode: 'singlerow',
            
                
            
                       
                columns: [
							
							 
                          
                              { text: 'DOC NO', datafield: 'doc_no', width: '10%',hidden:true},
                              { text: 'BRAND', datafield: 'brand', width: '25%' },
                              { text: 'BRAND NAME', datafield: 'brand_name', width: '75%' }
						
			
	             
						]
            });
            
          $('#jqxbrandSearch').on('rowdoubleclick', function (event) {
            	var rowindex1 =$('#rowindex').val();
            	// alert(rowindex1);
                var rowindex2 = event.args.rowindex;
                $('#jqxEnquiry').jqxGrid('setcellvalue', rowindex1, "brand" ,$('#jqxbrandSearch').jqxGrid('getcellvalue', rowindex2, "brand_name"));
                $('#jqxEnquiry').jqxGrid('setcellvalue', rowindex1, "brdid" ,$('#jqxbrandSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                document.getElementById("brandval").value=$('#jqxbrandSearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
                document.getElementById("gridval").value=1;
                var rows = $('#jqxEnquiry').jqxGrid('getrows');
                var rowlength= rows.length;
                if(rowindex1==rowlength-1)
                {
                	  $("#jqxEnquiry").jqxGrid('addrow', null, {});	
                }
              
                document.getElementById("errormsg").innerText="";
                
                
              $('#brandsearchwndow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="jqxbrandSearch"></div>