<%@page import="com.dashboard.workshop.partsdisbursmentfancy.*" %>
<%ClsWSPartsDisbursmentFancyDAO partsdao=new ClsWSPartsDisbursmentFancyDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String jobdocno=request.getParameter("jobdocno")==null?"":request.getParameter("jobdocno");
%>

<script type="text/javascript">
var id='<%=id%>';
var creditdata=[];
if(id=="1"){  
	creditdata='<%=partsdao.getCreditData(id,jobdocno)%>';
}else{
	creditdata=[];
}  
	
	$(document).ready(function(){
        var rendererstring=function (aggregates){
	     	var value=aggregates['sum'];
	     	if(value=="undefined" || value=="" || value==null || typeof(value)=="undefined"){
	     		value=0.0;
	     	}
	     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
		}
        var source =
        {
            datatype: "json",
            datafields: [
                      	{name : 'psrno' , type: 'number'},
 						{name : 'productname', type: 'string'},
 						{name : 'qty', type: 'number'},
 						{name : 'costprice', type:'number'},
 						{name : 'total',type:'number'}
						
                      	
             ],
             localdata: creditdata,
            
            
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



        $("#creditGrid").jqxGrid(
                {
                	width: '100%',
                    height: 200,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                  	editable:false,
                    altrows:true,
                     columnsresize: true,
                    showaggregates:true,
                    showstatusbar:true,
                    //Add row method
                    columns: [
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '10%',cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   }, 
						
						/*{ text: 'Part No',datafield: 'psrno', width: '10%'},*/
    					{ text: 'Part Name',datafield: 'productname', width: '60%'},
    					{ text: 'Qty',datafield: 'qty', width: '10%'},
    					{ text: 'Cost Price',datafield: 'costprice', width: '10%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
    					{ text: 'Total',datafield: 'total', width: '10%',align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring}
    	              ]
                });

	});
</script>
<div id="creditGrid"></div>