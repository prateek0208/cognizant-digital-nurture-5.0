package com.cognizant.ormlearn.service;

import com.cognizant.ormlearn.model.Skill;
import com.cognizant.ormlearn.repository.SkillRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Service
public class SkillService {

    @Autowired
    private SkillRepository skillRepository;

    @Transactional(readOnly = true)
    public Skill getSkill(int id) {
        Optional<Skill> skill = skillRepository.findById(id);
        return skill.orElse(null);
    }
    
    @Transactional
    public void saveSkill(Skill skill) {
        skillRepository.save(skill);
    }
}
