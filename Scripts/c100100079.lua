--Ｓｐ－手札抹殺
function c100100079.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_HANDES+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c100100079.cost)
	e1:SetTarget(c100100079.target)
	e1:SetOperation(c100100079.activate)
	c:RegisterEffect(e1)
end
function c100100079.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	if chk==0 then return tc:IsCanRemoveCounter(tp,0x91,5,REASON_COST) end	 
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	tc:RemoveCounter(tp,0x91,5,REASON_COST)	
end
function c100100079.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local h1=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
		if e:GetHandler():IsLocation(LOCATION_HAND) then h1=h1-1 end
		local h2=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)
		return (h1>0 or h2>0) and (h1==0 or Duel.IsPlayerCanDraw(tp,h1)) and (h2==0 or Duel.IsPlayerCanDraw(1-tp))
	end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,PLAYER_ALL,1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,PLAYER_ALL,1)
end
function c100100079.activate(e,tp,eg,ep,ev,re,r,rp)
	local h1=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	local h2=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,LOCATION_HAND)
	Duel.SendtoGrave(g,REASON_EFFECT+REASON_DISCARD)
	Duel.BreakEffect()
	Duel.Draw(tp,h1,REASON_EFFECT)
	Duel.Draw(1-tp,h2,REASON_EFFECT)
end