const tagsInput = document.getElementById('article_tags')
const tagList = document.getElementById('tag-list')

let tags = []

function removeTag(element, tag) {
	let index = tags.indexOf(tag)
	tags.splice(index, 1)
	element.remove()
	console.log(tags)
}

function createTag() {
	tagList.innerHTML = ''
	tags.forEach((tag) => {
		let spanTag = document.createElement('span')
		spanTag.className = 'tag-default tag-pill'

		let closeIcon = document.createElement('i')
		closeIcon.className = 'ion-close-round'
		closeIcon.addEventListener('click', function () {
			removeTag(spanTag, tag)
		})

		spanTag.appendChild(closeIcon)

		let textNode = document.createTextNode(tag)
		spanTag.appendChild(textNode)

		tagList.appendChild(spanTag)
	})
}

function addTag(e) {
	if (e.key == 'Enter') {
		e.preventDefault()
		let inputTags = e.target.value.split(',').map((tag) => tag.trim().toLowerCase()) // 小文字化とトリミング
		inputTags.forEach((tag) => {
			if (tag.length > 1 && !tags.includes(tag)) {
				if (tags.length < 5) {
					tags.push(tag)
				}
			}
		})
		createTag()
		e.target.value = ''
		console.log(tags)
	}
}

tagsInput.addEventListener('keydown', addTag)
