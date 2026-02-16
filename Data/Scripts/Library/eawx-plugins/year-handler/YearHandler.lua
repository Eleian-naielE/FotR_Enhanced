require("deepcore/std/class")
CONSTANTS = ModContentLoader.get("GameConstants")

---@class YearHandler
YearHandler = class()

---@param start_year integer
---@param id string
function YearHandler:new(start_year, start_month, id)
    self.EventLibrary = require("YearlyEventLibrary")

    self.start_year = start_year
    self.start_month = start_month
    self.suffix = CONSTANTS.YEAR_SUFFIX
    self.events = true
    self.cycle_of_month = -1 --prevents first update from advancing month
	self.cycles_per_month = 1

    if id == "DEFAULT" or id == "HISTORICAL" or id == "FTGU" or id == "CUSTOM" then
        self.events = false
    end

    if start_year == nil then
        self.start_year = CONSTANTS.START_YEAR
    end

    if start_month == nil then
        self.start_month = 1
    end

    self.current_year = self.start_year
    self.current_month = self.start_month

    if Find_Object_Type("fotr") then
		self.cycles_per_month = 2
		if id == id == "HISTORICAL" then -- FotR_Enhanced
            self.cycles_per_month = 3
        end
        if self.start_year == 22 then
            self.current_month = 6
        end
    end

    if self.suffix == "BBY" then
        GlobalValue.Set("GALACTIC_YEAR", 0 - self.current_year)
    else
        GlobalValue.Set("GALACTIC_YEAR", self.current_year)
    end

    GlobalValue.Set("GALACTIC_MONTH", self.current_month)

    self.current_year_text = tostring(self.current_year) .." ".. self.suffix.. " month "..tostring(self.current_month)
end

function YearHandler:update()
    self.cycle_of_month = self.cycle_of_month + 1
    crossplot:publish("CYCLE_CHANGE", "empty")

    if self.cycle_of_month >= self.cycles_per_month then
        self.current_month = self.current_month + 1
        self.cycle_of_month = 0
    end

    if self.current_month == 13 then
        if self.suffix == "BBY" then
            self.current_year = self.current_year - 1
            GlobalValue.Set("GALACTIC_YEAR", 0 - self.current_year)
        else
            self.current_year = self.current_year + 1
            GlobalValue.Set("GALACTIC_YEAR", self.current_year)
        end
        self.current_month = 1
        if self.current_year == 0 then
            if self.suffix == "BBY" then
                self.suffix = "ABY"
            end
        end
        crossplot:publish("ENTER_"..self.current_year..self.suffix, "empty")
    end

    local year_only_text = tostring(self.current_year) .." ".. self.suffix
    self.current_year_text = year_only_text.. " month "..tostring(self.current_month)

    if self.events == false then
        return
    end

    if self.EventLibrary[year_only_text] then
        for _, event in pairs(self.EventLibrary[year_only_text]) do
            if event.month == self.current_month and self.cycle_of_month == 0 then
                if event.params then
                    crossplot:publish(event.name, unpack(event.params))
                else
                    crossplot:publish(event.name, "empty")
                end
            end
        end
    end
end

return YearHandler
