<%@page import="com.dashboard.workshop.servicedesk.*" %>
<%ClsWSServiceDeskDAO floordao=new ClsWSServiceDeskDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String jobcarddocno=request.getParameter("jobcarddocno")==null?"":request.getParameter("jobcarddocno");
%>
<style>
	.yellowClass{
		background-color:#FDFF79;
	}
	.greenClass{
		background-color:#79FFA0;
	}
	.blueClass{
		background-color:#79B6FF;
	}
	.redClass{
		background-color:#FF8579;
	}
</style>
<script type="text/javascript">
var id='<%=id%>';
var partsdetailsdata=[];
if(id=="1"){
	partsdetailsdata='<%=floordao.getPartsData(id,jobcarddocno,jobcarddocno)%>';
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
        var cellclassname = function (row, column, value, data) {
        	if(data.availability=='AVAILABLE'){
            	return "greenClass";
            }
        	else if(data.availability=='PENDING'){
            	return "yellowClass";
            }
        	else if(data.availability=='NOT AVAILABLE'){
            	return "redClass";
            } 
            else{
            	return "yellowClass";
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
						{ text: 'Sr. No.',datafield: '',columntype:'number',cellclassname: cellclassname, width: '10%',cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },      
    					{ text: 'Description',datafield: 'description', width: '50%',cellclassname: cellclassname},
    					{ text: 'Est Qty',datafield: 'qty', width: '10%',cellsformat:'d',cellclassname: cellclassname},
    					{ text: 'Req. Qty',datafield: 'requestqty', width: '10%',cellsformat:'d',cellclassname: cellclassname},
    					{ text: 'Pur. Qty',datafield: 'purchaseqty', width: '10%',cellsformat:'d',cellclassname: cellclassname},
    					{ text: 'Bal. Qty',datafield: 'balanceqty', width: '10%',cellsformat:'d',cellclassname: cellclassname},
						{ text: 'Availability',datafield: 'availability', width: '10%',hidden:true,cellclassname: cellclassname}
						
    	              ]
                });

	});
</script>
<div id="partsDetailsGrid"></div>