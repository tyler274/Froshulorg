//table sorting code
$(function()
{
	function clickHandler(rowIndex)
	{
		return function(){
			console.log('click handler running for ' + rowIndex);
			var rows = $('.tableRow');
			sortBy(rows, rowIndex);
			rows.detach();
			$('.sortableTable').append(rows);
		};
	}
	var head = $('.tableHead')[0];
	for(var i = 0; i < head.children.length; i++)
	{
		console.log('adding click handler ' + i);
		head.children[i].onclick = clickHandler(i);
	}
});

function sortBy(rows, index)
{
	rows.sort(function(a, b)
	{
		var astr = a.children[index].textContent;
		var bstr = b.children[index].textContent;
		if($.isNumeric(astr) && $.isNumeric(bstr))
		{
			return (parseInt(astr) - parseInt(bstr));
		}
		else
		{
			if(astr > bstr)
			{
				return 1;
			}
			else if(astr < bstr)
			{
				return -1;
			}
			else
			{
				return 0;
			}
		}
	});
}
