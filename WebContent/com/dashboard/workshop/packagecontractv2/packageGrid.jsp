<style type="text/css">
	.greenClass{
		background-color:#79FFA0;
	}
</style>
<script type="text/javascript">
var packurl='getInitData.jsp?mode=2';
	$(document).ready(function(){
        
        var source =
        {
            datatype: "json",
            datafields: [
                      	{name : 'doc_no' , type: 'number' },
                      	{name : 'voc_no' , type: 'number' },
                      	{name : 'cldocno' , type: 'number' },
 						{name : 'refname', type: 'string'  },
                      	{name : 'packagename', type: 'string'  },
                      	{name : 'fromdate',type:'date'},
                      	{name : 'todate',type:'date'},
                      	{name : 'date',type:'date'},
                      	{name : 'remarks',type:'string'},
                      	{name : 'srsdocno',type:'number'},
                      	{name : 'outstatus',type:'number'},
                      	{name : 'srsvocno',type:'string'},
                      	{name : 'modelname',type:'string'},
                      	{name : 'regno',type:'string'},
                      	{name : 'chassisno',type:'string'},
                      	{name : 'brhid',type:'string'}
             ],
             url: packurl,
            
            
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


		var cellclassname = function (row, column, value, data) {
        	if(parseInt(data.srsdocno)>0){
            	return "greenClass";
            }
        };
        $("#packageGrid").jqxGrid(
                {
                	width: '100%',
                    height: 500,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                    sortable: true,
                    editable: false,
                    altrows:true,
                    //Add row method
                    columns: [
						{ text: 'Sr. No.',cellclassname: cellclassname,datafield: '',columntype:'number', width: '3%',editable:false, cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },      
    					{ text: 'Doc No',datafield: 'doc_no', width: '4%',hidden:true,editable:false,cellclassname: cellclassname },
    					{ text: 'Doc No',datafield: 'voc_no', width: '4%',editable:false,cellclassname: cellclassname },
    					{ text: 'Client #',datafield: 'cldocno', width: '4%',editable:false,cellclassname: cellclassname },
    					{ text: 'Date',datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy',hidden:true,editable:false,cellclassname: cellclassname },
    					{ text: 'Client Name',datafield: 'refname', width: '20%',editable:false,cellclassname: cellclassname },
    					{ text: 'Package Name',datafield: 'packagename', width: '10%' ,editable:false,cellclassname: cellclassname},
    					{ text: 'Model Name',datafield:'modelname',width: '15%',editable:false,cellclassname: cellclassname},
    					{ text: 'Reg No',datafield:'regno',width: '5%',editable:false,cellclassname: cellclassname},
    					{ text: 'Chassis No',datafield:'chassisno',width: '10%',editable:false,cellclassname: cellclassname},
    					{ text: 'From Date',datafield: 'fromdate', width: '5%',cellsformat:'dd.MM.yyyy',editable:false,cellclassname: cellclassname },
    					{ text: 'To Date',datafield: 'todate', width: '5%',cellsformat:'dd.MM.yyyy',editable:false ,cellclassname: cellclassname},
    					{ text: 'Remarks',datafield:'remarks',width: '15%',editable:false,cellclassname: cellclassname},
    					{ text: 'SRS Doc No',datafield:'srsdocno',width: '10%',editable:false,hidden:true,cellclassname: cellclassname},
    					{ text: 'Not Received Status',datafield:'outstatus',width: '10%',editable:false,hidden:true,cellclassname: cellclassname},
    					{ text: 'SRS No',datafield:'srsvocno',width: '4%',editable:false,cellclassname: cellclassname},
    					{ text: 'Branch Id',datafield:'brhid',width: '4%',editable:false,cellclassname: cellclassname,hidden:true},

    	              ]
                });

    	$('#packageGrid').on('rowdoubleclick', function (event) 
		{ 
		    var args = event.args;
		    // row's bound index.
		    var boundIndex = args.rowindex;
		    // row's visible index.
		    var visibleIndex = args.visibleindex;
		    // right click.
		    var rightclick = args.rightclick; 
		    // original event.
		    var ev = args.originalEvent;
		    $('#contractdocno').val($('#packageGrid').jqxGrid('getcellvalue',boundIndex,'doc_no'));
		    $('#contractvocno').val($('#packageGrid').jqxGrid('getcellvalue',boundIndex,'voc_no'));
			var clientname=$('#packageGrid').jqxGrid('getcellvalue',boundIndex,'refname');
			var doctext='Contract #'+$("#contractvocno").val()+' for '+clientname;
			$('.textpanel p').text(doctext);
			$('#gridindex').val(boundIndex);
			var contractdocno=$('#contractdocno').val();
			$('#utilGrid').jqxGrid('clear');
			getFields(contractdocno);
			
		});
	});
	
	function getFields(contractdocno){
		if(contractdocno!='0'){
			$.get('getUtilGridData.jsp',{'contractdocno':contractdocno,'mode':1},function(data){
				data=JSON.parse(data);
				var fieldarray=new Array();
				var columnarray=new Array();
				customfields=[];
				customcolumns=[];
				fieldarray.push({'name' : 'itemdesc' , 'type': 'string' });
				fieldarray.push({'name' : 'pkgorgqty' , 'type': 'number' });
				fieldarray.push({'name' : 'code' , 'type': 'string' });
				columnarray.push({ 'text': 'Description','datafield': 'itemdesc',});
				columnarray.push({ 'text': 'Package Qty','datafield': 'pkgorgqty', 'width': '10%','cellsformat':'d2'});
				columnarray.push({ 'text': 'Code','datafield': 'code', 'width': '10%','hidden':true});
				
				$.each(data.fieldarray,function(index,value){
					var estserial='est'+index;
					var estvocno='EST #'+value.estvocno;
					fieldarray.push({'name' : estserial,'type':'number'});
					columnarray.push({ 'text': estvocno,'datafield': estserial, 'width': '10%','cellsformat':'d2'});
				});
				fieldarray.push({name : 'pkgqty' , type: 'number' });
				columnarray.push({ 'text': 'Balance Qty','datafield': 'pkgqty', 'width': '10%','cellsformat':'d2'});
				
				customfields=fieldarray;
				customcolumns=columnarray;
				console.log(customfields);
				console.log(customcolumns);
				$('#utilgriddiv').load('utilGrid.jsp?contractdocno='+contractdocno);	
				
			});	
		}
		
	}
</script>
<div id="packageGrid"></div>
<input type="hidden" name="gridindex" id="gridindex">