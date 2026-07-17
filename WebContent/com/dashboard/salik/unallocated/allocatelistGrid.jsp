  <%@page import="com.dashboard.salik.ClstempSalikDAO"%> 
 
 <%
 
 ClstempSalikDAO showDAO = new  ClstempSalikDAO();
           	String chval = request.getParameter("chval")==null?"NA":request.getParameter("chval").trim();
	String uptodate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
	
	 String tagno = request.getParameter("tagno")==null || request.getParameter("tagno")==""?"":request.getParameter("tagno");
	 String regno = request.getParameter("regno")==null || request.getParameter("regno")==""?"":request.getParameter("regno");
// String RR="RR";
//System.out.println("----chval-----"+chval);
           	  %> 
<script type="text/javascript">
 var temp4='<%=chval%>';
var datas2;
var exceldatas;
if(temp4=='10')
	{

	datas2='<%=showDAO.allocationlist1(uptodate,tagno,regno,chval)%>'; 

	}
else if(temp4=='2')
{ 

	datas2='<%=showDAO.unallocation1(uptodate,tagno,regno,chval)%>'; 
	exceldatas='<%=showDAO.unallocation1Excel(uptodate,tagno,regno,chval)%>';

}
else
{

	datas2;
	
	} 
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",       
        datafields: [
       
                          {name : 'trans', type: 'string'  },
						{name : 'tagno', type: 'string'  },
						{name : 'regno', type: 'string'  },
						{name : 'salik_date', type: 'date'  },

						{name : 'salik_time', type: 'string'  },

						{name : 'fleetno', type: 'string'  },
						{name : 'amount', type: 'string'  },
						{name : 'reason', type: 'string'  },
						{name : 'rano', type: 'string'  },
						{name : 'branch', type: 'string'  },
						{name : 'amount', type: 'string'  },
						
			/* 		
						{name : 'rdocno', type: 'string'  },
						{name : 'trans', type: 'string'  },
				
						{name : 'trancode', type: 'string'  } */
					
						
						],
				    localdata: datas2,
        
        
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
    
    
    $("#salikgrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [   	
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '3%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }  
					  },
                     	
                     	{ text: 'Transaction', datafield: 'trans', width: '13%'   },
						{ text: 'Tag NO', datafield: 'tagno', width: '13%' },
						{ text: 'Reg NO', datafield: 'regno', width: '10%' },
						{ text: 'Salik Date', datafield: 'salik_date', width: '12%',cellsformat:'dd.MM.yyyy'},

						{ text: 'Salik Time', datafield: 'salik_time', width: '10%'},

						{ text: 'Fleet', datafield: 'fleetno', width: '8%' },
						{ text: 'Amount', datafield: 'amount', width: '9%',cellsalign: 'right', align:'right' },
						{ text: 'RA No', datafield: 'rano', width: '5%'},
						{ text: 'Branch', datafield: 'branch', width: '5%'},
						{ text: 'Reason', datafield: 'reason', width: '22%'},
			
				/* 		{ text: 'RDoc NO', datafield: 'rdocno', width: '12%' },
						{ text: 'Trancode', datafield: 'trancode', width: '10%'   } */
						
					
					]
    
    });
    
    $("#overlay, #PleaseWait").hide(); 
	   
});

	
	
</script>
<div id="salikgrid"></div>