<%@page import="com.workshop.carfaregateinpassmaster.*" %>
<%ClsCarfareGateInPassDAO ccd=new ClsCarfareGateInPassDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
   <script type="text/javascript">
   var servicepackagedata=[];
   var id='<%=id%>';
   if(id=="1"){
   	servicepackagedata='<%=ccd.getServicePackageData(id)%>';
   }
        $(document).ready(function () { 	
            
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [  
                         	{name : 'doc_no' , type: 'number' },
     						{name : 'name', type: 'String'  },
     						{name : 'code', type: 'String'  },
     						{name : 'amount', type: 'number'  },
                        	{name : 'date', type: 'date'  }
           
                  ],
                 localdata: servicepackagedata,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                  ///  alert(error);    
	                    }
		            }		
            );
            $("#servicePackageSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                altRows: true,
                selectionmode: 'singlerow',
                columnsresize: true,
              
                 columns: [
                       	{ text: 'Doc No', datafield: 'doc_no', width: '20%' },
					{ text: ' Code', datafield: 'code', width: '20%' },
					{ text: ' Name', datafield: 'name', width: '40%' },
					{ text: ' Amount', datafield: 'amount', width: '20%' ,cellsformat:'d2',align:'right',cellsalign:'right'},
					{ text: ' Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy',hidden:true }
				
					]
            });
       
  $('#servicePackageSearchGrid').on('rowdoubleclick', function (event) {
                
            	var rowindex1=event.args.rowindex;
                document.getElementById("hidservicepackage").value= $('#servicePackageSearchGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("servicepackage").value=$('#servicePackageSearchGrid').jqxGrid('getcellvalue', rowindex1, "name");
                $('#servicepackagewindow').jqxWindow('close');
            }); 
          
        });
    </script>
    <div id="servicePackageSearchGrid"></div>
