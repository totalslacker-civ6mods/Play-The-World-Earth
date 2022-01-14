--Emergencies
UPDATE EmergencyAlliances SET ShareVis = 0 WHERE EmergencyType = 'EMERGENCY_MILITARY';
UPDATE EmergencyAlliances SET ShareVis = 0 WHERE EmergencyType = 'EMERGENCY_SETTLED_CITY';
UPDATE EmergencyAlliances SET ShareVis = 0 WHERE EmergencyType = 'EMERGENCY_TRIGGER_CAPTURE_CITY_STATE';
UPDATE EmergencyAlliances SET ShareVis = 0 WHERE EmergencyType = 'EMERGENCY_NUCLEAR';
UPDATE EmergencyAlliances SET ShareVis = 0 WHERE EmergencyType = 'EMERGENCY_BACKSTAB';