local GetItemInfo = GetItemInfo
local GetItemQualityColor = GetItemQualityColor

local origs = {}
local tips = {GameTooltip, ItemRefTooltip, ShoppingTooltip1, ShoppingTooltip2}

local OnTooltipSetItem = function(self, ...)
	local orig = origs[self]
	if(orig) then orig(self, ...) end

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
	origs[obj] = obj:GetScript"OnTooltipSetItem"
	obj:SetScript("OnTooltipSetItem", OnTooltipSetItem)
end
