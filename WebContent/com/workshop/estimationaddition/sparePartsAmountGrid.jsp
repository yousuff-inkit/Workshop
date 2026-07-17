<%@page import="com.workshop.estimationaddition.*" %>
<%ClsEstimationAdditionDAO gatedao=new ClsEstimationAdditionDAO();
String gatedocno=request.getParameter("gatedocno")==null?"":request.getParameter("gatedocno");
String id=request.getParameter("id")==null?"":request.getParameter("id");
String addition=request.getParameter("addition")==null?"":request.getParameter("addition");
%>
<script type="text/javascript">
var sparepartsamountdata;
var id='<%=id%>';
if(id=="1"){
	sparepartsamountdata='<%=gatedao.getSparepartsAmountData(gatedocno,id,addition)%>'; 
}
$(document).ready(function () { 
	var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	if(value!="" && value!=null && value!="undefined"){
     		
     	}
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
     }
     var source =
     {
         datatype: "json",
         datafields: [
				{name : 'description', type: 'string'   },
				{name : 'genuinetotal', type: 'number'   },
				{name : 'markettotal',type:'number'},
				{name : 'usedtotal',type:'number'},
				{name : 'approvedtotal',type:'number'},
				{name : 'vatpercent',type:'number'}
          ],
          localdata: sparepartsamountdata,
         
         
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

            
            
            $("#sparePartsAmountGrid").jqxGrid(
            {
                width: '99%',
                height: 150,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlecell',
                pagermode: 'default',
                editable:false,
                showaggregates:true,
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
							{ text: 'Description', datafield: 'description', width: '50%'},		
							{ text: 'Tax Percent', datafield: 'vatpercent', width: '10%',align:'right',cellsalign:'right',cellsformat:'d2'},	
							{ text: 'Genuine', datafield: 'genuinetotal', width: '10%',align:'right',cellsalign:'right',cellsformat:'d2'},
							{ text: 'Market', datafield: 'markettotal', width: '10%',align:'right',cellsalign:'right',cellsformat:'d2'},
							{ text: 'Used', datafield: 'usedtotal', width: '10%',align:'right',cellsalign:'right',cellsformat:'d2'},
							{ text: 'Approved', datafield: 'approvedtotal', width: '10%',align:'right',cellsalign:'right',cellsformat:'d2'}
			              ]
            });
            
        });
    </script>
 <div id="sparePartsAmountGrid"></div>
    	