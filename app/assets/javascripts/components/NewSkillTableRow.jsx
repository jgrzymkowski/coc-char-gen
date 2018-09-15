class NewSkillTableRow extends React.Component {

  render() {
    const { label, attribute, basePercentage, additions } = this.props
    let value
    if(basePercentage !== null) {
      value = Math.min(_.reduce(additions, (sum, add) => sum + add, basePercentage), 80)
    }
    return (
      <tr>
        {this._renderLabel(label, basePercentage, additions)}
        <td>
          {_.isEmpty(label) ? <span>&nbsp;</span> : value}
          <input
            type="hidden"
            name={`dg_skill_set[${attribute}]`}
            id={`dg_skill_set_${attribute}`}
            value={value || ''} />
        </td>
      </tr>
    )
  }

  _renderLabel(label, basePercentage, additions) {
    if(_.isEmpty(label)) {
      return <td></td>
    }

    const additionsHtml = _.map(additions, (addition, i) => <span key={i} className="skill-addition">+{addition}</span>)
    const base = basePercentage === null ? '' : `(${basePercentage}%)`
    return (
      <td>{label} {base} {additionsHtml}</td>
    )
  }
}

NewSkillTableRow.propTypes = {
  label: PropTypes.string,
  attribute: PropTypes.string,
  basePercentage: PropTypes.number,
  additions: PropTypes.arrayOf(PropTypes.number)
}
