class EditSkillSet extends React.Component {
  render() {
    const { characterId, baseSkills, skillSet, skillSetId, authenticityToken } = this.props
    const editableSkills = _.compact(_.map(_.values(baseSkills), (baseSkill) => {
      const label = this._skillLabel(baseSkill)
      if(!_.isEmpty(label)) {
        return {
          id: baseSkill.id,
          label: this._skillLabel(baseSkill),
          percentage: skillSet[baseSkill.id] || 0
      }
      }
    }))
    const tableLength = Math.ceil(editableSkills.length/3)
    return (
        <form
          method="post"
          action={`/dg/characters/${characterId}/skill_sets/${skillSetId}`} >
          {this._renderSubmit()}
          <input type="hidden" name="_method" value="put" />
          <input
            type="hidden"
            name="authenticity_token"
          value={authenticityToken} />
          <div className="grid-x grid-padding-x align-center skill-set">
              {this._renderTable(editableSkills.slice(0, tableLength ))}
              {this._renderTable(editableSkills.slice(tableLength, tableLength*2))}
              {this._renderTable(editableSkills.slice(tableLength*2, tableLength*3))}
          </div>
      </form>
    )
  }

  _renderTable(editableSkills) {
    return (
      <div className="cell small-12 medium-4 large-4">
        <table>
          <tbody>
            {_.map(editableSkills, (editableSkill) => {
              return (
                <EditSkillTableRow
                  key={editableSkill.id}
                  label={editableSkill.label}
                  attribute={editableSkill.id}
                  value={editableSkill.percentage} />
                )
            })}
          </tbody>
        </table>
      </div>
    )
  }

  _skillLabel(baseSkill) {
    const { skillSet } = this.props
    const skillId = baseSkill.id

    if(skillId.match(/_\d/)) {
      if(skillSet[skillId] == 0 ) {
        return null
      } else {
        return _.get(skillSet, `${skillId}_text`)
      }
    }

    return baseSkill.label
  }

  _renderSubmit() {
    return (
      <div className="clearfix">
        <div className="float-right">
          <a className="button secondary" href={`/dg/characters/${this.props.characterId}`}>Cancel</a>
          <button type="submit" className="button">Save</button>
        </div>
      </div>
    )
  }
}

EditSkillSet.propTypes = {
  characterId: PropTypes.number,
  authenticityToken: PropTypes.string,
  baseSkills: PropTypes.object,
  skillSet: PropTypes.object
}
