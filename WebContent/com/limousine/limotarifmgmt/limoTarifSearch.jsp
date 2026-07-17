<%@page import="com.limousine.limotarifmgmt.*" %>
<%ClsLimoTarifDAO tarifdao=new ClsLimoTarifDAO(); %>
<script type="text/javascript">
/* $('#frmTariffManagement select').attr('disabled', false);  */
      var searchdata= '<%=tarifdao.masterSearch()%>';
  
  
        $(document).ready(function () { 	
            

            //var url="demo.txt"; 
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
                             
                          	{name : 'doc_no' , type: 'int' },
     						{name : 'date', type: 'String'  },
     						{name : 'tariftype', type: 'String'  },
     						{name : 'tariffor', type:'String'},
     						{name : 'fromdate', type:'date'},
     						{name : 'todate', type:'date'},
     						{name : 'desc1', type:'String'},
     						{name : 'tarifclient', type:'String'},
     						{name : 'refname', type: 'String'},
     						{name : 'branchname',type:'string'},
     						{name : 'delstatus',type:'string'}
     						
                 ],
                localdata: searchdata,
                //url: url,
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                   // alert(error);    
	                    }
		            }		
            );
            $("#limoTarifSearch").jqxGrid(
            {
                width: '100%',
                height: 372,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                //sortable: true,
                selectionmode: 'singlerow',
                filterable:true,
                showfilterrow:true,
                //Add row method
                columns: [
							{ text: 'Doc No', datafield: 'doc_no', width: '8%' },
							{ text: 'Date', datafield: 'date', width: '60%',cellsformat:'dd.MM.yyyy',hidden:true },
							{ text: 'Tarif Type', datafield: 'tariftype', width: '20%' },
							{ text: 'Tarif For', datafield: 'tariffor', width:'20%',hidden:true},
							{ text: 'From Date', datafield: 'fromdate', width:'20%',cellsformat:'dd.MM.yyyy'},
							{ text: 'To Date', datafield: 'todate', width:'20%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Description', datafield:'desc1',width:'32%'},
							{text: 'Client Id',datafield:'tarifclient',width:'20%',hidden:true},
							{text: 'Client Name',datafield:'refname',width:'20%',hidden:true},
							
	              ]
            });
           
            $('#limoTarifSearch').on('rowdoubleclick', function (event) {
            	var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#limoTarifSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                $("#date").jqxDateTimeInput('val',$("#limoTarifSearch").jqxGrid('getcellvalue', rowindex1, "date"));
                $("#fromdate").jqxDateTimeInput('val',$("#limoTarifSearch").jqxGrid('getcellvalue', rowindex1, "fromdate"));
                $("#todate").jqxDateTimeInput('val',$("#limoTarifSearch").jqxGrid('getcellvalue', rowindex1, "todate"));
                $('#cmbtariftype').val($("#limoTarifSearch").jqxGrid('getcellvalue', rowindex1, "tariftype")) ;
                $('#cmbtariffor').val($("#limoTarifSearch").jqxGrid('getcellvalue', rowindex1, "tariffor")) ;
                
           		if($("#limoTarifSearch").jqxGrid('getcellvalue', rowindex1, "refname")!="" && $("#limoTarifSearch").jqxGrid('getcellvalue', rowindex1, "refname")!=null && typeof($("#limoTarifSearch").jqxGrid('getcellvalue', rowindex1, "refname"))!="undefined"){
           			document.getElementById("tarifclient").value=$("#limoTarifSearch").jqxGrid('getcellvalue', rowindex1, "refname");
           			document.getElementById("hidtarifclient").value=$("#limoTarifSearch").jqxGrid('getcellvalue', rowindex1, "tarifclient");
           		}
           		
           		document.getElementById("desc").value=$("#limoTarifSearch").jqxGrid('getcellvalue', rowindex1, "desc1");
           		document.getElementById("hidchkdelivery").value=$("#limoTarifSearch").jqxGrid('getcellvalue', rowindex1, "delstatus");
           		setValues();
                 $('#window').jqxWindow('close');
                // $( "#docno" ).focus();
                
            });  
        });
    </script>
    <div id="limoTarifSearch"></div>
