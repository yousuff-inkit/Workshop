 <%@page import="com.dashboard.workshop.jobprofitabilitypivot.ClsJobProfitabilityDAO" %>   
 <%@page import="javax.servlet.http.HttpServletRequest" %>
 <%@page import="javax.servlet.http.HttpSession" %>
<%
ClsJobProfitabilityDAO sd=new ClsJobProfitabilityDAO();
%>  
 <% String fromdate =request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").toString();%>
 <% String todate =request.getParameter("todate")==null?"0":request.getParameter("todate").toString();%>
 <% String id =request.getParameter("id")==null?"0":request.getParameter("id").toString();
 %>
 <script type="text/javascript">
         var data;      
         data= '<%= sd.getSummaryData( fromdate, todate, id)%>';           
	     $(document).ready(function () {   
	    	 var rendererstring1=function (aggregates){  
	             	var value=aggregates['sum'];
	             	if(typeof(value) == "undefined"){
	             		value=0.00;
	             	}
	             	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
	             }
            // create a data source and data adapter
            var source =
            {
                localdata: data,  
                datatype: "json",
                datafields:
                [
					 {name : 'invdate', type: 'date' },  
					 {name : 'jobno', type: 'String' },
					 {name : 'invoiceno', type: 'String' },
					 {name : 'date',type: 'date' },
					 {name : 'regno',type: 'string' },
					 {name : 'make',type: 'string' },
					 {name : 'party', type: 'string' },
					 {name : 'insurname', type: 'string' },
					 {name : 'invamt',type: 'number' },   
					 {name : 'labouramt',type: 'number' },
					 {name : 'spareamt',type: 'number' },
					 {name : 'consamt',type: 'number' },
					 {name : 'labourcost', type: 'number' },
					 {name : 'sparescost', type: 'number' },
					 {name : 'conscost', type: 'number' },
					 {name : 'paintscost',type: 'number' },
					 {name : 'lubecost',type: 'number' },
					 {name : 'totcost',type: 'number' },
					 {name : 'profit', type: 'number' },
                ]
            };
            var dataAdapter = new $.jqx.dataAdapter(source);
            dataAdapter.dataBind();
            // create a pivot data source from the dataAdapter
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
						{dataField : 'invdate', text: 'Inv Date' },  
						{dataField : 'jobno', text: 'Job No' },
						{dataField : 'invoiceno', text: 'Inv No' },
						{dataField : 'date',text: 'Date' },
						{dataField : 'regno',text: 'Reg No' },
						{dataField : 'make',text: 'Make' },
						{dataField : 'party', text: 'Party' },
						{dataField : 'insurname', text: 'Insur Name' },
						{dataField : 'invamt',text: 'Inv Amt' },   
						{dataField : 'labouramt',text: 'Labour Amt' },
						{dataField : 'spareamt',text: 'Spare Amount' },
						{dataField : 'consamt',text: 'Cons Amt' },
						{dataField : 'labourcost', text: 'Labour Cost' },
						{dataField : 'sparescost', text: 'Spare Cost' },
						{dataField : 'conscost', text: 'Cons Cost' },
						{dataField : 'paintscost',text: 'Paints Cost' },
						{dataField : 'lubecost',text: 'Lube Cost' },
						{dataField : 'totcost',text: 'Total Cost' },
						{dataField : 'profit', text: 'Profit' } 
                    ],
                    rows: [
                       		{dataField : 'party', text: 'Party' },
                    ],
                 columns: [
                            
                          
                              ], 
                    values: [
							{dataField : 'invamt',text: 'Inv Amt','function': 'sum', align: 'right', formatSettings: { decimalPlaces: 2, align: 'right' }, cellsClassName: 'myItemStyle', cellsClassNameSelected: 'myItemStyleSelected' },   
							{dataField : 'labouramt',text: 'Labour Amt','function': 'sum', align: 'right', formatSettings: { decimalPlaces: 2, align: 'right' }, cellsClassName: 'myItemStyle', cellsClassNameSelected: 'myItemStyleSelected' },
							{dataField : 'spareamt',text: 'Spare Amount','function': 'sum', align: 'right', formatSettings: { decimalPlaces: 2, align: 'right' }, cellsClassName: 'myItemStyle', cellsClassNameSelected: 'myItemStyleSelected' },
							{dataField : 'consamt',text: 'Cons Amt','function': 'sum', align: 'right', formatSettings: { decimalPlaces: 2, align: 'right' }, cellsClassName: 'myItemStyle', cellsClassNameSelected: 'myItemStyleSelected' },
							{dataField : 'labourcost', text: 'Labour Cost' ,'function': 'sum', align: 'right', formatSettings: { decimalPlaces: 2, align: 'right' }, cellsClassName: 'myItemStyle', cellsClassNameSelected: 'myItemStyleSelected'},
							{dataField : 'sparescost', text: 'Spare Cost','function': 'sum', align: 'right', formatSettings: { decimalPlaces: 2, align: 'right' }, cellsClassName: 'myItemStyle', cellsClassNameSelected: 'myItemStyleSelected' },
							{dataField : 'conscost', text: 'Cons Cost','function': 'sum', align: 'right', formatSettings: { decimalPlaces: 2, align: 'right' }, cellsClassName: 'myItemStyle', cellsClassNameSelected: 'myItemStyleSelected' },
							{dataField : 'paintscost',text: 'Paints Cost','function': 'sum', align: 'right', formatSettings: { decimalPlaces: 2, align: 'right' }, cellsClassName: 'myItemStyle', cellsClassNameSelected: 'myItemStyleSelected' },
							{dataField : 'lubecost',text: 'Lube Cost','function': 'sum', align: 'right', formatSettings: { decimalPlaces: 2, align: 'right' }, cellsClassName: 'myItemStyle', cellsClassNameSelected: 'myItemStyleSelected' },
							{dataField : 'totcost',text: 'Total Cost' ,'function': 'sum', align: 'right', formatSettings: { decimalPlaces: 2, align: 'right' }, cellsClassName: 'myItemStyle', cellsClassNameSelected: 'myItemStyleSelected'},
							{dataField : 'profit', text: 'Profit','function': 'sum', align: 'right', formatSettings: { decimalPlaces: 2, align: 'right' }, cellsClassName: 'myItemStyle', cellsClassNameSelected: 'myItemStyleSelected' } 
                      ]         
                });
            var localization = { 'var': 'Variance' };          
            // create a pivot grid
            $('#jqxleaddataGrid').jqxPivotGrid(
            {
                localization: localization,
                source: pivotDataSource,
                treeStyleRows: true,
                autoResize: false,   
                multipleSelectionEnabled: true,
            });
            var pivotGridInstance = $('#jqxleaddataGrid').jqxPivotGrid('getInstance');
            // create a pivot grid
            $('#divPivotGridDesigner').jqxPivotDesigner(
            {
                type: 'pivotGrid',
                target: pivotGridInstance
            });
      	  $("#overlay, #PleaseWait").hide();
        });
    </script>
       <div id="jqxleaddataGrid"></div>