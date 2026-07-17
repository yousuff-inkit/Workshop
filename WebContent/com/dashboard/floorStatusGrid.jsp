<%@page import="com.dashboard.ClsDashBoardDAO"%>
<% ClsDashBoardDAO DAO= new ClsDashBoardDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<script type="text/javascript">
   
        $(document).ready(function () { 	
        	  
        	var datas6= '<%=DAO.floorStatusGridLoading()%>';
            
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'stat', type: 'string'  },
     						{name : 'val', type: 'number'   }
                        ],
                		  localdata: datas6, 
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };

            var dataAdapter = new $.jqx.dataAdapter(source);
            
            var tooltiprenderer = function (element) {
                $(element).jqxTooltip({position: 'mouse', content: $(element).text() });
            };
            
            $("#enquiryStatusGridID").jqxGrid(
            {
                width: '99%',
                height: 190,
                source: dataAdapter,
                columnsresize: true,
                sortable: true,
                altrows: true,
                enabletooltips: true,
                filtermode:'excel',
                filterable: true,
                rowsheight: 23,
                selectionmode: 'singlerow',
                       
                columns: [
                          
							{ text: 'STATUS', datafield: 'stat', rendered: tooltiprenderer, width: '70%' },
							{ text: 'COUNT', datafield: 'val', cellsalign: 'center', align: 'center',rendered: tooltiprenderer, width: '30%' },
						]
            });
            
        });
</script>
<div id="enquiryStatusGridID"></div>