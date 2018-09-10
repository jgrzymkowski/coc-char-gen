class NewSkillTableRow extends React.Component {

  render() {
    const { label, attribute, basePercentage, additions } = this.props
    const value = _.reduce(additions, (sum, add) => sum + add, basePercentage)
    const description = this._description(label, basePercentage, additions)
    return (
      <tr>
        <td>{description}</td>
        <td>
          {_.isEmpty(description) ? <span>&nbsp;</span> : value}
          <input
            type="hidden"
            name={`dg_skill_set[${attribute}]`}
            id={`dg_skill_set_${attribute}`}
            value={value || ''} />
        </td>
      </tr>
    )
  }

  _description(label, basePercentage, additions) {
    if(_.isEmpty(label)) {
      return ''
    }

    if(_.isEmpty(basePercentage)) {
      return label
    }

    const additionsHtml = _.map(additions, (addition, i) => <span key={i} class="skill-addition">{addition}</span>)
    return `${label} (${basePercentage}%) ${additionsHtml}`
  }
}

NewSkillTableRow.propTypes = {
  label: PropTypes.string,
  attribute: PropTypes.string,
  basePercentage: PropTypes.number,
  additions: PropTypes.arrayOf(PropTypes.number)
}
