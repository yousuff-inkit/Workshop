 <%@page import="com.dashboard.limousine.jobclose.ClsLimoJobCloseDAO" %>
 <%ClsLimoJobCloseDAO closedao=new ClsLimoJobCloseDAO();
 String jobdocno=request.getParameter("jobdocno")==null?"":request.getParameter("jobdocno");
 String bookdocno=request.getParameter("bookdocno")==null?"":request.getParameter("bookdocno");
 String id=request.getParameter("id")==null?"0":request.getParameter("id");
 %>
 
<script type="text/javascript">
var amountdata=[];
var id='<%=id%>';
if(id=="1"){
	amountdata='<%=closedao.getAmountData2(jobdocno, bookdocno, id)%>';
}
        $(document).ready(function () { 	

                    
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [ 
                            {name:'guest',type:'string'},
                            {name:'guestno',type:'number'},
                            {name:'jobtype',type:'string'},
                            {name:'jobname',type:'string'},
                            {name:'jobdocno',type:'string'},
                            {name:'bookdocno',type:'string'},
                            {name:'tarif',type:'number'},
                            {name:'nighttarif',type:'number'},
                            {name:'excesskmchg',type:'number'},
                            {name:'excesshrchg',type:'number'},
                            {name:'excessnighthrchg',type:'number'},
                            {name:'fuelchg',type:'number'},
                            {name:'parkingchg',type:'number'},
                            {name:'otherchg',type:'number'},
                            {name:'greetchg',type:'number'},
                            {name:'vipchg',type:'number'},
                            {name:'boquechg',type:'number'},
                            {name:'total',type:'number'}
                 ],               
               localdata:amountdata,
               
              
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

            
            
            $("#amountGrid").jqxGrid(
            {
                width: '99%',
                height: 250,
                source: dataAdapter,
                columnsresize: true,
                //showaggregates:true,
                //showstatusbar:true,
                //statusbarheight:25,
                //pageable: true,
                editable: true,
                altRows: true,
                /* showfilterrow: true, */
                /* filterable: true, */ 
               // sortable: true,
                selectionmode: 'singlecell',
               // pagermode: 'default',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                    var cell = $('#amountGrid').jqxGrid('getselectedcell');
                  /*   if (cell != undefined && cell.datafield == 'total' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                         var commit = $("#amountGrid").jqxGrid('addrow', null, {});
                            num++;            
                            
                        }
                      /*   $("#amountGrid").jqxGrid('selectcell', rowindex+1, 'account');
                        $("#amountGrid").jqxGrid('focus', rowindex+1, 'account');
                    } */ 
                    var cell1 = $('#amountGrid').jqxGrid('getselectedcell');
                   
					},
                
                //Filter
                /* ready: function () {
                    addfilter();
                }, */
                
                
                columns: [
                            { text: 'Sr. No.',datafield: '',columntype:'number', width: '4%', cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }   },
                            { text: 'Guest',datafield:'guest',width:'10%'},
                            { text:'Guest No',datafield:'guestno',hidden:true},
                            { text: 'Job Type',datafield:'jobtype',width:'8%'},
                            { text: 'Job Name',datafield:'jobname',width:'8%',hidden:true},
                            { text: 'Job Name',datafield:'jobnametemp',width:'6%',cellsrenderer: function (row, columnfield, value, defaulthtml, columnproperties) {
								var bookdocno=$('#amountGrid').jqxGrid('getcellvalue',row,'bookdocno');
								var jobname=$('#amountGrid').jqxGrid('getcellvalue',row,'jobname');
					        	return "<div style='overflow:hidden;text-overflow:ellipsis;padding-bottom:2px;text-align:left;margin-right:2px;margin-left:4px;margin-top:4px;'>" + (bookdocno+" - "+jobname) + "</div>";
					    	}},
                            { text: 'Job Doc No',datafield:'joobdocno',width:'20%',hidden:true},
                            { text: 'Book Docno',datafield:'bookdocno',width:'10%',hidden:true},
                            { text: 'Total', datafield: 'total', width: '8%' ,cellsalign:'right',cellsformat:'D2',align:'right'},
                            { text: 'Rental', datafield: 'tarif', width: '8%' ,cellsalign:'right',cellsformat:'D2',align:'right'},
                            { text: 'Night Tarif', datafield: 'nighttarif', width: '8%' ,cellsalign:'right',cellsformat:'D2',align:'right'},
                            { text: 'Excess Km Chg', datafield: 'excesskmchg', width: '8%' ,cellsalign:'right',cellsformat:'D2',align:'right'},
                            { text: 'Excess Hr Chg', datafield: 'excesshrchg', width: '8%' ,cellsalign:'right',cellsformat:'D2',align:'right'},
                            { text: 'Excess Night Hr chg', datafield: 'excessnighthrchg', width: '8%' ,cellsalign:'right',cellsformat:'D2',align:'right'},
                            { text: 'Fuel Chg', datafield: 'fuelchg', width: '8%' ,cellsalign:'right',cellsformat:'D2',align:'right'},
                            { text: 'Parking Chg', datafield: 'parkingchg', width: '8%' ,cellsalign:'right',cellsformat:'D2',align:'right'},
                            { text: 'Other Chg', datafield: 'otherchg', width: '8%' ,cellsalign:'right',cellsformat:'D2',align:'right'},
                            { text: 'Greet Chg', datafield: 'greetchg', width: '8%' ,cellsalign:'right',cellsformat:'D2',align:'right'},
                            { text: 'VIP Chg', datafield: 'vipchg', width: '8%' ,cellsalign:'right',cellsformat:'D2',align:'right'},
                            { text: 'Boque Chg',datafield: 'boquechg', width: '8%' ,cellsalign:'right',cellsformat:'D2',align:'right'}
                            
	              ]
            });
       
    
     });
    </script>
    <div id="amountGrid"></div>
   