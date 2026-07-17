<%@page import="com.dashboard.workshop.gateoutpassdetails.ClsGOPDetailsDAO" %>
<%ClsGOPDetailsDAO floordao=new ClsGOPDetailsDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String jobcarddocno=request.getParameter("jobcarddocno")==null?"":request.getParameter("jobcarddocno");
%>

<script type="text/javascript">
var id='<%=id%>';
var partsdetailsdata=[];
if(id=="1"){
	partsdetailsdata='<%=floordao.getPartsData(id,jobcarddocno,"")%>';
}
	$(document).ready(function(){
        
        var source =
        {
            datatype: "json",
            datafields: [
                      	{name : 'description' , type: 'string'},
 						{name : 'qty', type: 'number'},
 						{name : 'requestqty',type:'number'},
 						{name : 'purchaseqty',type:'number'},
 						{name : 'balanceqty',type:'number'},
 						{name : 'availability',type:'string'},
                      	
                      	
             ],
             localdata: partsdetailsdata,
            
            
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



        $("#partsDetailsGrid").jqxGrid(
                {
                	width: '100%',
                    height: 300,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                  	editable:false,
                    altrows:true,
                     columnsresize: true,
                    //Add row method
                    columns: [
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '10%',cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },      
    					{ text: 'Description',datafield: 'description', width: '50%'},
    					{ text: 'Est Qty',datafield: 'qty', width: '10%',cellsformat:'d'},
    					{ text: 'Req. Qty',datafield: 'requestqty', width: '10%',cellsformat:'d'},
    					{ text: 'Pur. Qty',datafield: 'purchaseqty', width: '10%',cellsformat:'d'},
    					{ text: 'Bal. Qty',datafield: 'balanceqty', width: '10%',cellsformat:'d'},
						{ text: 'Availability',datafield: 'availability', width: '10%',hidden:true}
    	              ]
                });

	});
</script>
<div id="partsDetailsGrid"></div>