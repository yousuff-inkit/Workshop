<%@page import="com.limousine.limosetup.airport.*" %>
<%ClsAirportDAO airportdao=new ClsAirportDAO(); %>
<script type="text/javascript">
    var airportdata='<%=airportdao.getSearchData()%>';
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number'},
     						{name : 'iatacode', type: 'String'  },
                          	{name : 'airport', type: 'String'  },
                          	{name : 'location', type: 'String'  },
                          	{name : 'country',type:'string'},
                          	{name : 'date',type:'date'}
                          	],
                 localdata: airportdata,
                
                
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
            $("#airportSearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                //pagermode: 'default',
                sortable: true,
                //Add row method
	
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
					{ text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
					{ text: 'IATA',datafield:'iatacode',width:'20%'},
					{ text: 'Airport',datafield:'airport',width:'60%'}
					]
            });
                 
            $('#airportSearch').on('rowdoubleclick', function (event) 
            		{ 
            	var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#airportSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("location").value=$('#airportSearch').jqxGrid('getcellvalue', rowindex1, "location");
                document.getElementById("iata").value=$('#airportSearch').jqxGrid('getcellvalue', rowindex1, "iatacode");
                document.getElementById("airport").value=$('#airportSearch').jqxGrid('getcellvalue', rowindex1, "airport");
                document.getElementById("country").value=$('#airportSearch').jqxGrid('getcellvalue', rowindex1, "country");
				$('#date').jqxDateTimeInput('val',$('#airportSearch').jqxGrid('getcellvalue', rowindex1, "date"));
                $('#window').jqxWindow('close');
            		 }); 

            
        });
    </script>
    <div id="airportSearch"></div>
