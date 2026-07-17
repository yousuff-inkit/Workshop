<%@page import="com.workshop.setup.servicepackage.*" %>
<%ClsServicePackageDAO ccd=new ClsServicePackageDAO();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
%>
<script>
$(document).ready(function() {
var comdata= '<%=ccd.getServicePackData(docno) %>';
	             var num = 0; 
            var source =
            {                            
                datatype: "json",
                datafields: [  
                          	{name : 'jobdocno' , type: 'number' },
     						{name : 'jobdate', type: 'date'  },
     						{name : 'jobtype', type: 'String'  },
     						{name : 'jobdesc', type: 'string'  }
          
                 ],
                 localdata: comdata,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                  //  alert(error);    
	                    }
		            }		
            );
            $("#servicePackageGrid").jqxGrid(
            {
                width: '100%',
                height: 315,
                source: dataAdapter,
                sortable: true,
                selectionmode: 'singlerow',

                columns: [
					{ text: 'Doc No', datafield: 'jobdocno', width: '10%' },
					{ text: ' Date', datafield: 'jobdate', width: '10%',cellsformat:'dd.MM.yyyy'},
					{ text: ' Type', datafield: 'jobtype', width: '20%' },
					{ text: ' Description', datafield: 'jobdesc', width: '60%' }					
					]
            });
      

            $('#servicePackageGrid').on('rowdoubleclick', function (event) {
                
            	var rowindex1=event.args.rowindex;
            	getJobs(rowindex1);
            }); 
            });
            </script>
            <div id="servicePackageGrid"></div>