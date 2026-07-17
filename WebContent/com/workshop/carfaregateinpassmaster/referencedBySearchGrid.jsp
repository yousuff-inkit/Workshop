<%@page import="com.workshop.carfaregateinpassmaster.*" %>
<%ClsCarfareGateInPassDAO dao=new ClsCarfareGateInPassDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var referencedbydata=[];
var id='<%=id%>';
if(id=="1"){
	referencedbydata='<%=dao.getReferencedByData(id)%>';
}
		$(document).ready(function () { 	
             
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'sal_code', type: 'String'  },
                          	{name : 'sal_name', type: 'String'  },
                          	{name : 'date', type: 'String'  },
                          	{name : 'acc_no', type: 'String'  },
                          	{name : 'description', type: 'String'  },
                          	{name : 'mobile',type:'String'},
                          	{name : 'mail',type:'String'}
                          	],
               localdata: referencedbydata,
                
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
            $("#referencedBySearchGrid").jqxGrid(
            {
                width: '100%',
                height: 340,
                source: dataAdapter,
                sortable: true,
                filtermode:'excel',
                filterable: true,
                selectionmode: 'singlerow',
                columnsresize: true,
                showfilterrow:true,

                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
					{ text: 'Code', datafield: 'sal_code', width: '15%' },
					{ text: 'Name', datafield: 'sal_name', width: '40%' },
					{ text: 'Acc No', datafield: 'acc_no', width: '40%',hidden:true },
					{ text: 'Account Name', datafield: 'description', width: '35%',hidden:true },
					{ text:'Mobile',datafield:'mobile', width: '35%',hidden:false },
					{ text:'Mail',datafield:'mail', width: '40%',hidden:true }
					]
            });
            $('#referencedBySearchGrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("hidreferencedby").value= $('#referencedBySearchGrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("referencedby").value = $("#referencedBySearchGrid").jqxGrid('getcellvalue', rowindex1, "sal_name");
                $('#referencedbywindow').jqxWindow('close');
            }); 
         
        });
    </script>
    <div id="referencedBySearchGrid"></div>
