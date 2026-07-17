<%@page import="com.dashboard.analysis.revenuereportpivot.*"%>
<%
ClsRevenueReportDAO DAO=new ClsRevenueReportDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String hidclient=request.getParameter("hidclient")==null?"":request.getParameter("hidclient");
String hidclientslm=request.getParameter("hidclientslm")==null?"":request.getParameter("hidclientslm");
String hidrepairtype=request.getParameter("hidrepairtype")==null?"":request.getParameter("hidrepairtype");
%>

<script type="text/javascript">
 
var id='<%=id%>';
var rrdetaildata;
var clockexportdata;


if(id=='1'){
	rrdetaildata=<%=DAO.getDetailData(fromdate,todate,hidclient,hidclientslm,hidrepairtype,id)%>;
	rrexportdata=<%=DAO.getDetailExportData(fromdate,todate,hidclient,hidclientslm,hidrepairtype,id)%>;

}
else{
	rrdetaildata=[];
}
 
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        localdata: rrdetaildata,
        datatype: "json",
        datafields: [
                  		
                  		{name : 'date',type:'date'},
                  		{name : 'invoiceno',type:'string'},
                  		{name : 'client',type:'string'},
                  		{name : 'jobno',type:'string'},
                  		{name : 'regno',type:'string'},
                  		{name : 'totalinv',type:'number'},
                  		{name : 'clienttotal',type:'number'},
                  		{name : 'excesstotal',type:'number'},
                  		{name : 'labour',type:'number'},
                  		{name : 'spares',type:'number'},
                  		{name : 'lubricants',type:'number'},
                  		{name : 'consumables',type:'number'},
                  		{name : 'others',type:'number'},
                  		{name : 'salesman',type:'string'},
                  		{name : 'repairtype',type:'string'},
                  		{name : 'serviceadvisor',type:'string'},
                  		{name : 'account',type:'string'},
                  		{name : 'clcategory',type:'string'},
                  		{name : 'estimator',type:'string'},
                  		{name : 'actualspare',type:'number'},
                		{name : 'estno',type:'string'},
                  		{name : 'esttotalvalue',type:'number'},
   						{name : 'estall',type:'string'},
   						{name : 'estapprvalue',type:'number'},
                  	
    ],
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
            dataAdapter.dataBind();
    
    
     var pivotDataSource = new $.jqx.pivot(
                dataAdapter,
                {
                    customAggregationFunctions: {
                        'var': function (values) {
                            if (values.length <= 1)
                                return 0;
                            // sample's mean
                            var mean = 0;
                            for (var i = 0; i < values.length; i++)
                                mean += values[i];
                            mean /= values.length;
                            // calc squared sum
                            var ssum = 0;
                            for (var i = 0; i < values.length; i++)
                                ssum += Math.pow(values[i] - mean, 2)
                            // calc the variance
                            var variance = ssum / values.length;
                            return variance;
                        }
                    },
                    pivotValuesOnRows: false,
                    fields: [
                         { dataField: 'date', text: 'Date'},
                         { dataField: 'invoiceno', text: 'Invoice No'},
                         { dataField: 'instype', text: 'Insurance type'},
                         { dataField: 'estimator', text: 'Estimator'},
                         { dataField: 'serviceadvisor', text: 'Service Advisor'},
                         { dataField: 'account', text: 'Account Name' },
                         { dataField: 'jobno', text: 'Job No' },
                         { dataField: 'estno', text: 'Est No' },  
                         { dataField: 'regno', text: 'Reg No' },
                         { dataField: 'clienttotal', text: 'Client' },
                         { dataField: 'estall', text: 'Est Doc No (Additions)' },
                         { dataField: 'spares', text: 'EST Spares' },
                         { dataField: 'esttotalvalue', text: 'EST Total' },
                         { dataField: 'totalinv', text: 'Total Inv Value' },
                         { dataField: 'labour', text: 'EST Labour' },
                         { dataField: 'estapprvalue', text: 'EST Appr. Value' },
                         { dataField: 'excesstotal', text: 'Ins. Co.' }, 
                         { dataField: 'actualspare', text: 'Actual Spare Parts' }, 
                         { dataField: 'lubricants', text: 'Lubricants' }, 
                         { dataField: 'consumables', text: 'Consumables' },
                         { dataField: 'others', text: 'Others' }, 
                         { dataField: 'salesman', text: 'Sales Man' },
                         { dataField: 'clcategory', text: 'Client Category' },
                    ],
                    rows: [
							{ dataField: 'client', text: 'Client Name'}, //width:400   
						
                    ],
                    columns: [
                            
                              { dataField: 'repairtype', text: 'Repair Type' },
                          
                              ],
                    values: [
                             { dataField: 'esttotalvalue', text: 'Est Total','function': 'sum', align: 'right', formatSettings: { decimalPlaces: 2, align: 'right' }, cellsClassName: 'myItemStyle', cellsClassNameSelected: 'myItemStyleSelected' },
                             { dataField: 'totalinv', text: 'Total Inv Value' ,'function': 'sum', align: 'right', formatSettings: { decimalPlaces: 2, align: 'right' }, cellsClassName: 'myItemStyle',cellsClassNameSelected: 'myItemStyleSelected'}     
                      ]         
                });
    
   var localization = { 'var': 'Variance' };        
            // create a pivot grid
            $('#rrDetailGrid').jqxPivotGrid(
            {
                localization: localization,
                source: pivotDataSource,
                treeStyleRows: true,
                autoResize: false,   
                multipleSelectionEnabled: true,
            });
            var pivotGridInstance = $('#rrDetailGrid').jqxPivotGrid('getInstance');
            // create a pivot grid
            $('#divPivotGridDesigner').jqxPivotDesigner(
            {
                type: 'pivotGrid',
                target: pivotGridInstance
            });
      	  $("#overlay, #PleaseWait").hide();
     
  
    });

	
	
</script>
<div id="rrDetailGrid"></div>