var CommentForm = React.createClass({
    getInitialState: function() {
        return {content: ''}
    },

    handleContentChange: function(e) {
        this.setState({content: e.target.value})
    },

    handleSubmit: function(e) {
        e.preventDefault();
        var content = this.state.content.trim();
        if(!content){
            return;
        }

        //send to server
        this.props.onCommentSubmit({comment: {content: content}})
        this.setState({content: ''})
    },

    render: function(){
        return (
                <form className="commentForm" onSubmit={this.handleSubmit}>
                    <textarea id="comment_content" rows="3" type="text" placeholder="Comment..." value={this.state.content} onChange={this.handleContentChange}/>
                    <input id="submit-comment" className="primary hollow button float-right" type="submit" value="Post"/>
                </form>
        );
    }
});