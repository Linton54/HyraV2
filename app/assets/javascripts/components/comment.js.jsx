var Comment = React.createClass({

    handleDelete: function (e){
        e.preventDefault()
        var v = confirm("Delete comment?")
        if(v == true)
          this.props.deleteComment({id: this.props.id})
    },

    render: function () {
        var deleteOption;
        if(this.props.current_id == this.props.commenter_id)
            deleteOption = <a onClick={this.handleDelete} className="tiny warning button del-button float-right" href="">Delete</a>

        return  <div className="comment">
                    <div className="row">
                        <div className="columns large-12">
                            <div className="uut-comment">
                                {deleteOption}
                                <div className="uimg-comment">
                                    <img className="thumbnail" src={this.props.avatar } alt="UserImg"/>
                                </div>
                                <div className="ut-comment">
                                    <a className="utu" href={"/users/" + this.props.username }>{ this.props.username }</a>
                                    <div className="utt">
                                      { this.props.time }
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div className="columns large-12 c-comment">
                            { this.props.content }
                        </div>



                    </div>
                </div>
    }
})