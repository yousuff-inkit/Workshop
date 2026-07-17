<%@page import="com.operations.marketing.servicemetrics.*" %>
<%ClsServiceMetricsDAO srvdao=new ClsServiceMetricsDAO(); %>
<script type="text/javascript">

var searchdata='<%=srvdao.mainSearch()%>';
		
		$(document).ready(function() { 
                   
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'doc_no', type: 'number' }, 
     						{name : 'tarifgroup', type: 'string'},
     						{name : 'gname',type:'string'},
     						{name : 'date',type:'date'},
     						{name : 'insurpercent',type:'number'},
     						{name : 'tracker',type:'number'},
     						{name : 'regcost',type:'number'},
     						{name : 'insurexcess',type:'number'},
     						{name : 'exkmrate',type:'number'}
                        	],
                         localdata: searchdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#mainSearch").jqxGrid(
            {
                width: '99%',
                height: 350,
                source: dataAdapter,
                editable: false,
                selectionmode: 'singlerow',
                filterable:true,
                showfilterrow:true,
                //Add row method
                handlekeyboardnavigation: function (event) {
                	/* var rows = $('#jqxleasecalculator').jqxGrid('getrows');
                 	var rowlength= rows.length;
                    var cell = $('#jqxleasecalculator').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'fifthyear' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {  
                            var commit = $("#jqxleasecalculator").jqxGrid('addrow', null, {});
                            rowlength++;                           
                        }
                    }  */
                },
                       
                columns: [
							
							{ text: 'Doc No', datafield: 'doc_no', width: '33.33%'},	
							{ text: 'Date', datafield: 'date', width: '33.33%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Tarif Group', datafield: 'gname', width: '33.33%'},
							{ text: 'Tarif Group Docno',datafield:'tarifgroup',width:'d2',hidden:true},
							{ text: 'Insur percent', datafield: 'insurpercent', width: '24%',hidden:true},
							{ text: 'Tracker', datafield: 'tracker', width: '24%',hidden:true},
							{ text: 'Reg Cost', datafield: 'regcost', width: '24%',hidden:true},
							{ text: 'Insur Excess',datafield:'insurexcess',width:'10%',hidden:true},
							{ text: 'Ex Km Rate',datafield:'exkmrate',width:'10%',hidden:true}
						]
            });
           
            
            $("#mainSearch").on('rowdoubleclick', function (event) 
                    {
            	 	var boundIndex = event.args.rowindex;
            	 	document.getElementById("docno").value=$('#mainSearch').jqxGrid('getcellvalue',boundIndex,'doc_no');
            	 	document.getElementById("hidtarifgroup").value=$('#mainSearch').jqxGrid('getcellvalue',boundIndex,'tarifgroup');
            	 	document.getElementById("tarifgroup").value=$('#mainSearch').jqxGrid('getcellvalue',boundIndex,'gname');
            	 	document.getElementById("insurpercent").value=$('#mainSearch').jqxGrid('getcellvalue',boundIndex,'insurpercent');
            	 	document.getElementById("tracker").value=$('#mainSearch').jqxGrid('getcellvalue',boundIndex,'tracker');
            	 	document.getElementById("regcost").value=$('#mainSearch').jqxGrid('getcellvalue',boundIndex,'regcost');
            	 	document.getElementById("insurexcess").value=$('#mainSearch').jqxGrid('getcellvalue',boundIndex,'insurexcess');
            	 	document.getElementById("exkmrate").value=$('#mainSearch').jqxGrid('getcellvalue',boundIndex,'exkmrate');
            	 	$('#date').jqxDateTimeInput('val',$('#mainSearch').jqxGrid('getcellvalue',boundIndex,'date'));
            	 	$('#srvmetricsdiv').load('serviceMetricsGrid.jsp?docno='+document.getElementById('docno').value+'&id=1');
            	 	$('#window').jqxWindow('close');
                    });
        });
		 
    </script>
    <div id="mainSearch"></div>
    
