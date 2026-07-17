<%@page import="com.workshop.gateinpass.*" %>
<%ClsGateInPassDAO gatedao=new ClsGateInPassDAO();
String clientdocno=request.getParameter("clientdocno")==null?"":request.getParameter("clientdocno");
String clientname=request.getParameter("clientname")==null?"":request.getParameter("clientname");
String clientaddress=request.getParameter("clientaddress")==null?"":request.getParameter("clientaddress");
String clientmobile=request.getParameter("clientmobile")==null?"":request.getParameter("clientmobile");
String clientmail=request.getParameter("clientmail")==null?"":request.getParameter("clientmail");
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var clientdata;
var id='<%=id%>';
if(id=="1"){
	clientdata='<%=gatedao.getClient(id,clientdocno,clientname,clientaddress,clientmobile,clientmail)%>';
}
$(document).ready(function () { 

     var source =
     {
         datatype: "json",
         datafields: [
				{name : 'cldocno', type: 'number'  },
				{name : 'refname', type: 'string'   },
				{name : 'address',type:'string'},
				{name : 'mobile',type:'string'},
				{name : 'mail',type:'string'},
				{name : 'clientdetails',type:'string'}
          ],
          localdata: clientdata,
         
         
         pager: function (pagenum, pagesize, oldpagenum) {
             // callback called when a page or page size is changed.
         }
                                 
     };
     
     var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
    			loadComplete: function () {
            		 $("#loadingImage").css("display", "none"); 
        		},
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
	            
            }		
    );


            
            
            $("#clientSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                    /* var cell = $('#jqxSpecification').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'DESCRIPTION' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#jqxSpecification").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    } */
                    
                },
                
                       
                columns: [
							{ text: 'Sr. No.',datafield: '',columntype:'number', width: '10%', cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }   },	
                            { text:'Doc No',datafield:'cldocno',width:'10%'},
							{ text:'Name', datafield: 'refname', width: '25%' },			
							{ text:'Address', datafield: 'address', width: '25%'},
							{text: 'Mobile',datafield:'mobile',width:'15%'},
							{ text: 'Mail',datafield:'mail',width:'15%'},
							{ text: 'Client Details',datafield:'clientdetails',hidden:true}
			              ]
            });
            
            $("#clientSearchGrid").on("rowdoubleclick", function (event) {
                var row1=event.args.rowindex;
                $('#gateInvoiceGrid').jqxGrid('clear');
				$('#client').val($('#clientSearchGrid').jqxGrid('getcellvalue',row1,'refname'));
				$('#hidclient').val($('#clientSearchGrid').jqxGrid('getcellvalue',row1,'cldocno'));
				
				$('#clientwindow').jqxWindow('close');
                });
        });
    </script>
    <div id="clientSearchGrid"></div>