local GetItemInfo = GetItemInfo
local GetItemQualityColor = GetItemQualityColor

local tips = {GameTooltip, ItemRefTooltip, ShoppingTooltip1, ShoppingTooltip2}

local OnTooltipSetItem = function(self, ...)
	local name, item = self:GetItem()
	if(item) then
		local _, _, quality = GetItemInfo(item)
		if(quality) then
			local r, g, b = GetItemQualityColor(quality)

			self:SetBackdropBorderColor(r, g, b)
			self:SetBackdropColor(0, 0, 0, 1)
		end
	end
end

for _, obj in ipairs(tips) do
	obj:HookScript("OnTooltipSetItem", OnTooltipSetItem)
end
